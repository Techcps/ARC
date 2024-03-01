
export PROJECT_ID=$(gcloud info --format='value(config.project)')
bq --location=US mk --dataset $PROJECT_ID:sports
bq --location=US mk --dataset $PROJECT_ID:soccer
bq mk --table $PROJECT_ID:soccer.premiership
