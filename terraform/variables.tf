variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "zone_id" {
  type = string
}

variable "server_ip" {
  type        = string
  sensitive   = true
  description = "Server IP address"
}