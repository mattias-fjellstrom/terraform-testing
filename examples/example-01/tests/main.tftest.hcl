run "file_contents_should_be_json" {
    command = plan

    assert {
        condition = try(jsondecode(local_file.config.content), null) != null
        error_message = "The file is not valid JSON"
    }
}