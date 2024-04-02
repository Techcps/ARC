
gcloud services enable cloudscheduler.googleapis.com --project=$DEVSHELL_PROJECT_ID

gcloud pubsub topics create cloud-pubsub-topic

gcloud pubsub subscriptions create cloud-pubsub-subscription --topic=cloud-pubsub-topic

gcloud scheduler jobs create pubsub cron-scheduler-job --schedule="* * * * *" --topic=cron-job-pubsub-topic --message-body="Hello World!" --time-zone="America/Los_Angeles" --location=$REGION

gcloud pubsub subscriptions pull cron-job-pubsub-subscription --limit 5

