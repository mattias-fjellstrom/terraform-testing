terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "website" {
  source = "./modules/web"
  providers = {
    azurerm = azurerm
  }
  location           = "swedencentral"
  name_prefix        = "web531"
  index_file_content = file("index.html")
}

check "validate_website_response" {
  data "http" "static_website" {
    url = module.website.web_endpoint
  }

  assert {
    condition     = data.http.static_website.status_code == 200
    error_message = "${data.http.static_website.url} returned an unhealthy status code"
  }

  assert {
    condition     = data.http.static_website.response_headers["Content-Type"] == "text/html"
    error_message = "${data.http.static_website.url} returned a wrong content-type header"
  }

  assert {
    condition     = strcontains(data.http.static_website.response_body, "Hello World")
    error_message = "${data.http.static_website.url} did not respond with expected content"
  }
}
