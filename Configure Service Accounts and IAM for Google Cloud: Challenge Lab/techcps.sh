

export PROJECT_ID=$(gcloud config get-value project)

gcloud iam service-accounts create devops --display-name devops

gcloud config configurations activate default

gcloud iam service-accounts list  --filter "displayName=devops"


SA=$(gcloud iam service-accounts list --format="value(email)" --filter "displayName=devops")

echo $SA

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA" \
    --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA" \
    --role="roles/compute.instanceAdmin"


