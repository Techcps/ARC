

export PROJECT_ID=$(gcloud config get-value project)

gsutil mb gs://$PROJECT_ID

bq mk $DATASET_NAME

bq mk --table \
$PROJECT_ID:$DATASET_NAME.$TABLE_NAME \
data:string

gcloud pubsub topics create $TOPIC_NAME

gcloud pubsub subscriptions create $TOPIC_NAME-sub --topic=$TOPIC_NAME



gcloud dataflow flex-template run $JOB_NAME --region $REGION \
--template-file-gcs-location gs://dataflow-templates-$REGION/latest/flex/PubSub_to_BigQuery_Flex \
--temp-location gs://$PROJECT_ID/temp/ \
--parameters outputTableSpec=$PROJECT_ID:$DATASET_NAME.$TABLE_NAME,\
inputTopic=projects/$PROJECT_ID/topics/$TOPIC_NAME,\
outputDeadletterTable=$PROJECT_ID:$DATASET_NAME.$TABLE_NAME,\
javascriptTextTransformReloadIntervalMinutes=0,\
useStorageWriteApi=false,\
useStorageWriteApiAtLeastOnce=false,\
numStorageWriteApiStreams=0



#!/bin/bash

while true; do
    STATUS=$(gcloud dataflow jobs list --region="$REGION" --format='value(STATE)' | grep Running)
    
    if [ "$STATUS" == "Running" ]; then
        echo "The Dataflow job is running successfully. then run next command."

        sleep 20
        gcloud pubsub topics publish $TOPIC_NAME --message='{"data": "73.4 F"}'

        bq query --nouse_legacy_sql "SELECT * FROM \`$DEVSHELL_PROJECT_ID.$DATASET_NAME.$TABLE_NAME\`"
        break
    else
        sleep 30
        echo "The Dataflow job is not running. please wait and subscribe to Techcps (https://www.youtube.com/@techcps)."
    fi
done


gcloud dataflow jobs run $JOB_NAME-techcps --gcs-location gs://dataflow-templates-$REGION/latest/PubSub_to_BigQuery --region=$REGION --project=$PROJECT_ID --staging-location gs://$PROJECT_ID/temp --parameters inputTopic=projects/$PROJECT_ID/topics/$TOPIC_NAME,outputTableSpec=$PROJECT_ID:$DATASET_NAME.$TABLE_NAME

while true; do
    STATUS=$(gcloud dataflow jobs list --region=$REGION --project=$PROJECT_ID --filter="name:$JOB_NAME-techcps AND state:Running" --format="value(state)")
    
    if [ "$STATUS" == "Running" ]; then
        echo "The Dataflow job is running successfully. then run next command."

        sleep 20
        gcloud pubsub topics publish $TOPIC_NAME --message='{"data": "73.4 F"}'

        bq query --nouse_legacy_sql "SELECT * FROM \`$PROJECT_ID.$DATASET_NAME.$TABLE_NAME\`"
        break
    else
        sleep 30
        echo "The Dataflow job is not running. subscribe to Techcps (https://www.youtube.com/@techcps)."
    fi
done



