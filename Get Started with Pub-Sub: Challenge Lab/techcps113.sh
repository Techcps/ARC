# Get the form number from the from input
read -p "Enter the Form number (1, 2, or 3): " form_number

# Function to run Form 1
cp_form_1() {
    gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

    gcloud pubsub topics create cloud-pubsub-topic

    gcloud pubsub subscriptions create 'cloud-pubsub-subscription' --topic=cloud-pubsub-topic

    gcloud scheduler jobs create pubsub cron-scheduler-job --schedule="* * * * *" --topic=cron-job-pubsub-topic --message-body="Hello World!" --location=$REGION

    gcloud pubsub subscriptions pull cron-job-pubsub-subscription --limit 5
}

# Function to run Form 2
cp_form_2() {
    gcloud beta pubsub schemas create city-temp-schema \
        --type=avro \
        --definition='{
            "type": "record",
            "name": "Avro",
            "fields": [
                {
                    "name": "city",
                    "type": "string"
                },
                {
                    "name": "temperature",
                    "type": "double"
                },
                {
                    "name": "pressure",
                    "type": "int"
                },
                {
                    "name": "time_position",
                    "type": "string"
                }
            ]
        }'

    gcloud pubsub topics create temp-topic --message-encoding=JSON --message-storage-policy-allowed-regions=$REGION --schema=projects/$DEVSHELL_PROJECT_ID/schemas/temperature-schema
}

# Function to run Form 3
cp_form_3() {
    gcloud pubsub snapshots create pubsub-snapshot --subscription=gcloud-pubsub-subscription

    gcloud pubsub lite-reservations create pubsub-lite-reservation --location=$REGION --throughput-capacity=2

    gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

    gcloud pubsub lite-topics create cloud-pubsub-topic-lite --location=$REGION --partitions=1 --per-partition-bytes=30GiB --throughput-reservation=demo-reservation

    gcloud pubsub lite-subscriptions create cloud-pubsub-subscription-lite --location=$REGION --topic=cloud-pubsub-topic-lite
}

# Run the function based on the selected form number
case $form_number in
    1) 
        cp_form_1 || cp_form_2 ;;
    2) 
        cp_form_2 || cp_form_3 ;;
    3) 
        cp_form_3 ;;
    *) 
        echo "CP Invalid form number. Please enter 1, 2, or 3." ;;
esac
