variable "cloudflare_account_id" { type = string }
variable "cloudflare_zone_id" { type = string }
variable "domain_name" { type = string }
variable "cloudflare_api_token" { type = string }
variable "tunnel_service_url" { type = string }
variable "apps" {
  type = map(object({
    subdomain = string
  }))
}
