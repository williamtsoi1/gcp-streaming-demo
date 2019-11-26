# GCP Streaming Data Pipeline demo walkthrough

## Introduction

The purpose of this demo is to demonstrate Google Cloud Platform's streaming data warehouse capability using the following technologies:
- 

## Set up environment

First we need to set up the environment. Please create a GCP project and then run the following in Cloud Shell:

```bash
gcloud config set project <PROJECT_ID>
```

## Create bucket to store helper scripts

Create bucket to store the helper scripts. We will create a bucket with the same name as your project, and the scripts will be copied into a "scripts" subdirectory inside the bucket.

```bash
gsutil mb gs://$GOOGLE_CLOUD_PROJECT
gsutil cp ./scripts/* gs://$GOOGLE_CLOUD_PROJECT/scripts/
```

## Create GCE instance for working

We will then create a GCE instance to run the rest of the exercise from. Please set the `ZONE` environment variable appropriately according to the region/zone that you want to use.

```bash
export ZONE=asia-east1-a
gcloud services enable compute.googleapis.com
gcloud compute instances create demo-instance --project $GOOGLE_CLOUD_PROJECT --zone $ZONE --scopes cloud-platform --metadata startup-script-url=gs://$GOOGLE_CLOUD_PROJECT/scripts/datademo.sh
```

## SSH into the GCE instance



```bash
gcloud compute ssh demo-instance --zone=$ZONE
```


