#! /bin/bash
#1.Download data-science-on-gcp source code & install related package

mkdir /datademo
cd /datademo
sudo apt-get update
yes|sudo apt-get install git
git clone https://github.com/GoogleCloudPlatform/data-science-on-gcp/
yes|sudo apt-get install default-jdk
yes|sudo apt-get install maven
yes|sudo apt-get install virtualenv -f
virtualenv -p python3 venv
source venv/bin/activate
yes|pip install google-cloud-bigquery
yes|pip install google-cloud-pubsub

#2.Download script to generate simulation data & start streaming data pipeline 

export PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
gsutil cp gs://$PROJECT_ID/scripts/start_dataflow.sh /datademo/start_dataflow.sh
gsutil cp gs://$PROJECT_ID/scripts/datagen.sh /datademo/datagen.sh
chmod +x /datademo/start_dataflow.sh
chmod +x /datademo/datagen.sh

#3.Create flight dataset and copy similation data & schema & create view for data studio virlization  

export PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
export VIEWSQL='CREATE VIEW IF NOT EXISTS `'$PROJECT_ID'.flights.flightdelays` AS SELECT
  airport,
  last[safe_OFFSET(0)].*,
  CONCAT(CAST(last[safe_OFFSET(0)].latitude AS STRING), ",",
        CAST(last[safe_OFFSET(0)].longitude AS STRING)) AS location
FROM (
  SELECT
    airport,
    ARRAY_AGG(STRUCT(arr_delay,
        dep_delay,
        timestamp,
        latitude,
        longitude,
        num_flights)
    ORDER BY
      timestamp DESC
    LIMIT
      1) last
  FROM
    `'$PROJECT_ID'.flights.streaming_delays`
  GROUP BY
    airport )'

bq mk flights
bq cp jerry-customer-demo:flightsdemo.simevents flights.simevents
bq cp jerry-customer-demo:flightsdemo.streaming_delays flights.streaming_delays
echo $VIEWSQL | bq query --use_legacy_sql=false
