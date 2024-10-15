

echo "Export the variables name correctly"


# Set the REGION name correctly
read -p "Enter REGION: " REGION

gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

gcloud pubsub topics create gcloud-pubsub-topic

gcloud pubsub subscriptions create pubsub-subscription-message --topic=gcloud-pubsub-topic

gcloud scheduler jobs create pubsub pubsub-subscription-message \
  --schedule="* * * * *" \
  --topic=gcloud-pubsub-topic \
  --message-body="Hello World!" \
  --location=$REGION


gcloud pubsub subscriptions pull pubsub-subscription-message --limit 5


gcloud pubsub snapshots create pubsub-snapshot --subscription=pubsub-subscription-message

