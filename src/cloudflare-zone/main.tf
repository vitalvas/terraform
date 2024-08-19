resource "cloudflare_zone" "main" {
  account_id = var.account_id
  zone       = var.name
  plan       = var.plan
  paused     = var.paused
  type       = var.type
  jump_start = false
}

resource "cloudflare_record" "main" {
  zone_id = cloudflare_zone.main.id

  for_each = {
    for record in var.records : md5(jsonencode(record)) => record
  }

  name     = try(each.value.name, var.name)
  type     = each.value.type
  content  = try(each.value.value, null)
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, false)
  ttl      = try(each.value.ttl, 1)

  dynamic "data" {
    for_each = each.value.type == "SRV" ? [1] : []

    content {
      name     = try(each.value.srv_name, var.name)
      service  = each.value.srv_service
      proto    = each.value.srv_proto
      priority = try(each.value.srv_priority, 0)
      weight   = try(each.value.srv_weight, 0)
      port     = try(each.value.srv_port, 0)
      target   = each.value.srv_target
    }
  }

  comment = "Managed by Terraform"
}
