resource "aws_route53_zone" "main" {
  name              = var.name
  delegation_set_id = var.delegation_set_id
}

resource "aws_route53_record" "main" {
  for_each = {
    for index, row in var.records : format("%s-%s", try(row.name, "__apex__"), row.type) => row
  }

  zone_id = aws_route53_zone.main.id

  name = lookup(each.value, "name", "") != "" ? "${each.value.name}.${var.name}" : var.name
  type = each.value.type
  ttl  = length(keys(lookup(each.value, "alias", {}))) == 0 ? lookup(each.value, "ttl", var.record_default_ttl) : null

  records = lookup(each.value, "records", null)

  allow_overwrite = var.record_allow_overwrite

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.name
      zone_id                = try(each.value.alias.zone_id, aws_route53_zone.main.id)
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }

  depends_on = [
    aws_route53_zone.main
  ]
}

resource "aws_route53_key_signing_key" "main" {
  for_each = toset(var.dnssec_kms_keys)

  hosted_zone_id = aws_route53_zone.main.id

  name                       = try(var.name, "main")
  key_management_service_arn = each.value
  status                     = try(each.value.inactive, false) ? "INACTIVE" : "ACTIVE"
}

resource "aws_route53_hosted_zone_dnssec" "main" {
  count = var.dnssec_enabled ? 1 : 0

  hosted_zone_id = aws_route53_zone.main.id

  depends_on = [
    aws_route53_zone.main
  ]
}