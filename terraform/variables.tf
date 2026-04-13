variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID for the domain"
  sensitive   = true
}

variable "domain_name" {
  type        = string
  description = "The root domain name"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with Zero Trust Tunnel permissions"
  sensitive   = true
}

variable "tunnel_service_url" {
  type        = string
  description = "Backend service URL for tunnel ingress"
}

variable "apps" {
  type = map(object({
    subdomain = string
  }))
  description = "Map of applications with their subdomains."
}

