# GCP Streaming Data Pipeline demo walkthrough

## Set up environment

```bash
gcloud config set project <PROJECT_ID>
```

Create bucket for startup script, copy files over

## Create bucket to store helper scripts
```bash
gsutil mb gs://$GOOGLE_CLOUD_PROJECT
gsutil cp ./scripts/* gs://$GOOGLE_CLOUD_PROJECT/scripts/
```

## Create GCE instance for working

```bash
export ZONE=asia-east1-a
gcloud compute instances create demo-instance --project $GOOGLE_CLOUD_PROJECT --zone $ZONE --scopes cloud-platform --metadata startup-script-url=gs://$GOOGLE_CLOUD_PROJECT/scripts/datademo.sh
```
