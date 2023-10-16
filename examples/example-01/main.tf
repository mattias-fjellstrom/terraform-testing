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
    "string": "hello",
    "bool": true,
    "int": 1,
    "list": [
        1,
        2,
        3
    ]
}
EOF
}
