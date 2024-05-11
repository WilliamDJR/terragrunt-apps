include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:iixlabs/yog-terraform-modules.git//terragrunt-modules/gcp/gcs-storage-bucket?ref=master"

  extra_arguments "parent_vars" {
    commands = ["plan", "destroy"]
  }

}

inputs = {
  region      = "asia-east1"
  bucket_name = "gcf-sources-asia-east1"
  bucket_use  = "function_code_storage"
  bucket_storage_class = "STANDARD"
}
