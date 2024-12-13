


# Set text styles
YELLOW=$(tput setaf 3)
BOLD=$(tput bold)
RESET=$(tput sgr0)


echo "Please set the below values correctly"
read -p "${YELLOW}${BOLD}Enter the ZONE: ${RESET}" ZONE

# Export variables after collecting input
export ZONE

export REGION="${ZONE%-*}"

echo $REGION


cat > cp_disk.sh <<'EOF_CP'
gcloud auth login --quiet

export PROJECT_ID=$(gcloud config get-value project)

export ZONE=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-zone])")

gcloud iam service-accounts create devops --display-name devops

gcloud config configurations activate default

gcloud iam service-accounts list --filter "displayName=devops"

SERVICE_ACCOUNT=$(gcloud iam service-accounts list --format="value(email)" --filter "displayName=devops")

echo $SERVICE_ACCOUNT

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/compute.instanceAdmin"

gcloud compute instances create vm-2 --project=$PROJECT_ID --zone=$ZONE --service-account=$SERVICE_ACCOUNT --scopes=https://www.googleapis.com/auth/bigquery

cat > role-definition.yaml <<EOF
title: Custom Role
description: Custom role with cloudsql.instances.connect and cloudsql.instances.get permissions
includedPermissions:
- cloudsql.instances.connect
- cloudsql.instances.get
EOF

gcloud iam roles create customRole --project=$PROJECT_ID --file=role-definition.yaml

gcloud iam service-accounts create bigquery-qwiklab --display-name bigquery-qwiklab

SERVICE_ACCOUNT=$(gcloud iam service-accounts list --format="value(email)" --filter "displayName=bigquery-qwiklab")

gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT --role=roles/bigquery.dataViewer

gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:$SERVICE_ACCOUNT --role=roles/bigquery.user

gcloud compute instances create bigquery-instance --project=$PROJECT_ID --zone=$ZONE --service-account=$SERVICE_ACCOUNT --scopes=https://www.googleapis.com/auth/bigquery
EOF_CP

sleep 10

echo $ZONE

export PROJECT_ID=$(gcloud config get-value project)

gcloud compute scp cp_disk.sh lab-vm:/tmp --project=$PROJECT_ID --zone=$ZONE --quiet

gcloud compute ssh lab-vm --project=$PROJECT_ID --zone=$ZONE --quiet --command="bash /tmp/cp_disk.sh"

sleep 45

cat > cp_disk.sh <<'EOF_CP'
sudo apt-get update

sudo apt install python3 -y

sudo apt-get install -y git python3-pip

sudo apt install python3.11-venv -y

python3 -m venv create myvenv

source myvenv/bin/activate

pip3 install --upgrade pip

pip3 install google-cloud-bigquery

pip3 install pyarrow

pip3 install pandas

pip3 install db-dtypes

pip3 install --upgrade google-cloud

export PROJECT_ID=$(gcloud config get-value project)
export SERVICE_ACCOUNT_EMAIL=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/email" -H "Metadata-Flavor: Google")

echo "
from google.auth import compute_engine
from google.cloud import bigquery
credentials = compute_engine.Credentials(
service_account_email='$SERVICE_ACCOUNT_EMAIL')
query = '''
SELECT name, SUM(number) as total_people
FROM "bigquery-public-data.usa_names.usa_1910_2013"
WHERE state = 'TX'
GROUP BY name, state
ORDER BY total_people DESC
LIMIT 20
'''
client = bigquery.Client(
  project='$PROJECT_ID',
  credentials=credentials)
print(client.query(query).to_dataframe())
" > query.py

sleep 10

python3 query.py
EOF_CP

sleep 10

echo $ZONE

export PROJECT_ID=$(gcloud config get-value project)

gcloud compute scp cp_disk.sh bigquery-instance:/tmp --project=$PROJECT_ID --zone=$ZONE --quiet

gcloud compute ssh bigquery-instance --project=$PROJECT_ID --zone=$ZONE --quiet --command="bash /tmp/cp_disk.sh"

