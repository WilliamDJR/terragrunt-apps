include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:Console-Core/terragrunt-modules.git//terragrunt-modules/gcp/generic-pubsub?ref=58aa069"

  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }
}

inputs = {
  product_name = "stop-instance"
  name         = "event"
  env_name     = "dev"
  topic_publisher_service_accounts = [
    
  ]
  topic_subscriber_service_accounts = [
    
  ]
}
