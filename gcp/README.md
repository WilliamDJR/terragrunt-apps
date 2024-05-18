# Description
This demo will create resources to automatically stop/start VMs with specific lables by terragrunt.

# 0. Prerequisites
1. Register a google account (New accounts have US$300 credits for 3 months) and create a project (a project will be created by default when you register the account).
2. Install terraform/terragrunt/gcloud cli tools.
3. Create a gcs bucket to store terraform remote state file, e.g `<yourname>-terraform-remote-state`
3. Clone this repo to your local laptop, e.g ~/git/terragrunt-apps.
4. Change the `project` and `gcp_state_bucket` in gcp/terragrunt.hcl to yours

# 1. Login
```
gcloud auth login
gcloud auth application-default login
```

# 2. Create VM(s) 
Creat one or more VMs with labels `startstop-schedule=weekdays` in the zone `australia-southeast1-a`
```
gcloud compute instances create INSTANCE_NAME \
    --zone=australia-southeast1-a \
    --machine-type=e2-micro \
    --labels=startstop-schedule=weekdays \
    --project=PROJECT_NAME
```
or in Windows Powershell
```
gcloud compute instances create INSTANCE_NAME `
    --zone=australia-southeast1-a `
    --machine-type=e2-micro `
    --labels=startstop-schedule=weekdays `
    --project=PROJECT_NAME
```

Note: Create at least one VM in the same configurations except for the labels if you don't have (for verification).

# 3. Create Pub/Sub and cloud scheduler
```
cd ~/git/terragrunt-apps/gcp/pub-sub/start-instance-event-pubsub
terragrunt plan
terragrunt apply
cd ~/git/terragrunt-apps/gcp/pub-sub/stop-instance-event-pubsub
terragrunt plan
terragrunt apply
```

# 4. Create Cloud Functions
- Create source code bucket and upload the source codes startInstancePubSub.zip stopInstancePubSub.zip.
```
cd ~/git/terragrunt-apps/gcp/cloud-functions/bucket-australia-southeast1
terragrunt plan
terragrunt apply
cd ~/git/terragrunt-apps/gcp/cloud-functions/sourceCodes
gsutils cp *.zip gs://<your_project>-gcf-sources-australia-southeast1
```
- Create Cloud Functions
```
cd ~/git/terragrunt-apps/gcp/cloud-functions/startInstancePubSub
terragrunt plan
terragrunt apply
cd ~/git/terragrunt-apps/gcp/cloud-functions/stopInstancePubSub
terragrunt plan
terragrunt apply
```
Note: You may get a timeout error because it might take more than 5 mins to create the function. Don't worry. Check the function status in gcp `Cloud Functions` console to make sure the function was created correctly.



