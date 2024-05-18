include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:WilliamDJR/terragrunt-modules.git//gcp/generic-pubsub?ref=main"

  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }
}

inputs = {
  product_name = "stop-instance"
  name         = "event"
  topic_publisher_service_accounts = [
    
  ]
  topic_subscriber_service_accounts = [
    
  ]
}
