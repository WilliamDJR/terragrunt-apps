include "gcp" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git::git@github.com:WilliamDJR/terragrunt-modules.git//gcp/gcs-storage-bucket?ref=main"

  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  bucket_name = "gcf-sources-${include.gcp.inputs.region}"
  bucket_use  = "function_code_storage"
  bucket_storage_class = "STANDARD"
}
