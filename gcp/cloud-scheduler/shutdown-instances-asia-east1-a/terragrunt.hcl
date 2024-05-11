include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:Console-Core/terragrunt-modules.git//terragrunt-modules/gcp/cloud-scheduler-pubsub?ref=82ffb4c"
#  source = "/home/wdong/git/terragrunt-modules/terragrunt-modules/gcp/cloud-scheduler-pubsub"
  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  region = "asia-east1"
  scheduler_name = "shutdown-instances-asia-east1-a"
  scheduler_description = "Shutdown labelled instances"
  scheduler_setting = "0 20 * * 1-5"
  scheduler_tz = "Australia/Brisbane"
  scheduler_target_topic = "projects/pccw-dev/topics/tf-dev-stop-instance-event-topic"
  scheduler_target_data = "{\"zone\":\"asia-east1-a\", \"label\":\"startstop-schedule=weekdays\"}"
}
