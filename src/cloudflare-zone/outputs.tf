output "zone_id" {
  value = cloudflare_zone.main.id
}

output "name_servers" {
  value = cloudflare_zone.main.name_servers
}
