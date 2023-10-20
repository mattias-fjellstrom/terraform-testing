variable "config_url" {
  type = string

  validation {
    condition     = startswith(var.config_url, "https://")
    error_message = "config_url should start with https://"
  }
}

variable "port" {
  type = number

  validation {
    condition     = var.port > 1023 && var.port <= 65535
    error_message = "Use an unprivileged port number (1024-65535)"
  }
}

variable "service_name" {
  type = string
}
