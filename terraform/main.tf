resource "random_password" "tunnel_secret" {
  length = 32
}

# 1. Create the Tunnel
resource "cloudflare_zero_trust_tunnel_cloudflared" "docker_tunnel" {
  account_id    = var.cloudflare_account_id
  name          = "docker_traefik_tunnel"
  tunnel_secret = base64encode(random_password.tunnel_secret.result)
  config_src    = "cloudflare"
}

# 2. Create DNS Records
resource "cloudflare_dns_record" "app_records" {
  for_each = var.apps

  zone_id = var.cloudflare_zone_id
  name    = each.value.subdomain
  content = "${cloudflare_zero_trust_tunnel_cloudflared.docker_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

# 3. Configure the Tunnel Ingress
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.docker_tunnel.id

  config = {
    ingress = concat(
      [
        for app in var.apps : {
          hostname = app.subdomain == "@" ? var.domain_name : "${app.subdomain}.${var.domain_name}"
          service  = var.tunnel_service_url
        }
      ],
      [{ service = "http_status:404" }] # Catch-all
    )
  }
}

# 4. Fetch the Token (Required in v5)
data "cloudflare_zero_trust_tunnel_cloudflared_token" "token" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.docker_tunnel.id
}

output "tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.token.token
  sensitive = true
}