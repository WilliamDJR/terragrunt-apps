
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "prod-williamd-tfstate" # Change to your own bucket to save remote terraform state file
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "prod-williamd-lock-table" # Change to your own dynamodb lock table
  }
}