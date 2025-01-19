include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/WilliamDJR/terragrunt-modules.git//aws/ec2?ref=main"
  #source = "/home/williamd/git/terragrunt-modules/aws//ec2"
}

inputs = {
  instance_name = "uat-demo-ec2"
  instance_type = "t2.micro"
}