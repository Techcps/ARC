

# Get the form number from the from input
read -p "Enter the Form number (1, 2, or 3): " form_number

# Function to run Form 1
cp_form_1() {
    echo "Export the variables name correctly"

    # Set the REGION name correctly
    read -p "Enter REGION: " REGION

    gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

    gcloud pubsub topics create cloud-pubsub-topic

    gcloud pubsub subscriptions create 'cloud-pubsub-subscription' --topic=cloud-pubsub-topic

    gcloud scheduler jobs create pubsub cron-scheduler-job --schedule="* * * * *" --topic=cron-job-pubsub-topic --message-body="Hello World!" --location=$REGION

    gcloud pubsub subscriptions pull cron-job-pubsub-subscription --limit 5
}

# Function to run Form 2
cp_form_2() {

    echo "Export the variables name correctly"

    # Set the REGION name correctly
    read -p "Enter REGION: " REGION

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
    echo "Export the variables name correctly"

    # Set the REGION name correctly
    read -p "Enter REGION: " REGION
  
    gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

    # gcloud pubsub topics create gcloud-pubsub-topic ---pre-created

    gcloud pubsub subscriptions create pubsub-subscription-message --topic=gcloud-pubsub-topic

    gcloud scheduler jobs create pubsub pubsub-subscription-message --schedule="* * * * *" --topic=gcloud-pubsub-topic --message-body="Hello World!" --location=$REGION

    gcloud pubsub subscriptions pull pubsub-subscription-message --limit 5

    gcloud pubsub snapshots create pubsub-snapshot --subscription=pubsub-subscription-message

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
