variable "location" {
  type = string

  validation {
    condition = contains([
      "swedencentral",
      "westeurope"
    ], var.location)
    error_message = "The selected location is not allowed!"
  }
}

variable "name_prefix" {
  type = string

  validation {
    condition     = length(var.name_prefix) <= 13
    error_message = "name_prefix variable too long, should be less than or equal to 13 characters"
  }
}

variable "index_file_content" {
  type = string
}
