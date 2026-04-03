terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}



resource "cloudflare_dns_record" "root" {
  zone_id = var.zone_id
  name    = "@"
  content = var.server_ip
  type    = "A"
  proxied = true
  ttl     = 1
}

resource "cloudflare_zone_setting" "ssl_setting" {
  zone_id    = var.zone_id
  setting_id = "ssl"
  value      = "full"
}

resource "cloudflare_zone_setting" "https_redirect" {
  zone_id    = var.zone_id
  setting_id = "always_use_https"
  value      = "on"
}
