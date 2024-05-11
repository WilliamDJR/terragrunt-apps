include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:Console-Core/terragrunt-modules.git//terragrunt-modules/gcp/gcf-cloud-function-event-trigger?ref=0a3f0c3"
  #source = "/home/wdong/git/terragrunt-modules/terragrunt-modules/gcp/gcf-cloud-function-event-trigger"
  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  region = "asia-east1"
  function_use = "StopInstance"
  function_name    = "stopInstancePubSub"
  function_runtime = "nodejs20"
  function_source_bucket = "pccw-dev-gcf-sources-asia-east1"
  function_source_object = "stopInstancePubSub.zip"
  function_entry_point  = "stopInstancePubSub"
  function_trigger_type = "google.pubsub.topic.publish"
  function_trigger_resource = "projects/pccw-dev/topics/tf-dev-stop-instance-event-topic" 
}
