variables {
  config_url   = "https://example.com"
  port         = 1414
  service_name = "my-service"
}

run "bad_input_url_should_fail" {
  command = plan

  variables {
    config_url = "http://example.com"
  }

  expect_failures = [
    var.config_url
  ]
}

run "bad_input_port_should_fail" {
  command = plan

  variables {
    port = 80
  }

  expect_failures = [
    var.port
  ]
}

run "too_large_output_file_should_fail_deployment" {
  command = plan

  variables {
    service_name = "this-service-name-creates-a-too-big-file"
  }

  expect_failures = [
    output.file_content_base64
  ]
}

run "file_contents_should_be_valid_json" {
  command = plan

  assert {
    condition     = try(jsondecode(local_file.config.content), null) != null
    error_message = "The file is not valid JSON"
  }
}