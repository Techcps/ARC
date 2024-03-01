
export PROJECT_ID=$(gcloud info --format='value(config.project)')
gcloud compute networks create staging --subnet-mode=custom --project=$PROJECT_ID
gcloud compute networks create development --project=$PROJECT_ID
gcloud compute networks subnets create dev-1 --network=development --project=$PROJECT_ID --region=$REGION --range=10.1.0.0/24
