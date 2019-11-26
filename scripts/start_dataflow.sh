export PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
export BUCKET=$PROJECT_ID-ml
gsutil mb gs://$BUCKET

cd /datademo/data-science-on-gcp/04_streaming/realtime/chapter4
mvn compile exec:java \
-Dexec.mainClass=com.google.cloud.training.flights.AverageDelayPipeline \
      -Dexec.args="--project=$PROJECT_ID \
      --stagingLocation=gs://$BUCKET/staging/ \
      --averagingInterval=60 \
      --speedupFactor=30 \
      --runner=DataflowRunner"

