terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

resource "local_file" "config" {
  filename = "config.json"
  content  = <<EOF
{
    "endpoint": "${var.config_url}",
    "port": "${var.port}",
    "service": "${var.service_name}"
}
EOF
}
