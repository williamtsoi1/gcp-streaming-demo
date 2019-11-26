cd /datademo
source venv/bin/activate
export PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
cd /datademo/data-science-on-gcp/04_streaming/simulate
python ./simulate.py --project $PROJECT_ID --startTime '2015-01-01 06:00:00 UTC' --endTime '2015-01-10 06:00:00 UTC' --speedFactor=300
