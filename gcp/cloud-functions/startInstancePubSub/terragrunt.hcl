include "gcp" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git::git@github.com:WilliamDJR/terragrunt-modules.git//gcp/gcf-cloud-function-event-trigger?ref=main"
  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  function_use = "StartInstance"
  function_name    = "startInstancePubSub"
  function_runtime = "nodejs20"
  function_source_bucket = "${include.gcp.inputs.project}-gcf-sources-${include.gcp.inputs.region}"
  function_source_object = "startInstancePubSub.zip"
  function_entry_point  = "startInstancePubSub"
  function_trigger_type = "google.pubsub.topic.publish"
  function_trigger_resource = "projects/${include.gcp.inputs.project}/topics/tf-${include.gcp.inputs.env_name}-start-instance-event-topic" 
}
