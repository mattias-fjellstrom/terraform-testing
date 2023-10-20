output "file_content_base64" {
  value = base64encode(local_file.config.content)

  precondition {
    condition     = length(base64encode(local_file.config.content)) < 150
    error_message = "Config file is too large."
  }
}
