include "gcp" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git::git@github.com:WilliamDJR/terragrunt-modules.git//gcp/cloud-scheduler-pubsub?ref=main"
  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  scheduler_name = "shutdown-instances-${include.gcp.inputs.region}-a"
  scheduler_description = "Shutdown labelled instances"
  scheduler_setting = "0 20 * * 1-5"
  scheduler_tz = "Australia/Brisbane"
  scheduler_target_topic = "projects/${include.gcp.inputs.project}/topics/tf-${include.gcp.inputs.env_name}-stop-instance-event-topic"
  scheduler_target_data = "{\"zone\":\"${include.gcp.inputs.region}-a\", \"label\":\"startstop-schedule=weekdays\"}"
}
