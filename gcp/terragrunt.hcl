remote_state {
  backend = "gcs"
  config = {
    bucket         = "wdong-terraform-remote-state"
    prefix         = "gcp-${path_relative_to_include()}/terraform.tfstate"
    encryption_key = get_env("GCS_ENCRYPTION_KEY", "")
  }
}

terraform {
  extra_arguments "parent_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      "terragrunt.hcl"
    ]
  }

  extra_arguments "output_plan" {
    commands = ["plan"]

    arguments = [
      "-input=false",
      "-out=terraform.plan"
    ]
  }

  extra_arguments "apply_plan" {
    commands = ["apply"]

    arguments = [
      "-input=false",
      "terraform.plan"
    ]
  }
}

inputs = {
  project          = "<project-name>"
  env_name         = "sandbox"
  gcp_state_bucket = "<gcp-state-bucket-name>"
  region      = "australia-southeast1"
}