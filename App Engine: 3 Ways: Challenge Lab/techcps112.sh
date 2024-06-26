

gcloud services disable appengine.googleapis.com

gcloud services enable appengine.googleapis.com

sleep 5

git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

cd python-docs-samples/appengine/standard_python3/hello_world

gcloud app create --region=$REGION

gcloud app deploy --quiet


INSTANCE_NAME=lab-setup

ZONE=$(gcloud compute instances describe $INSTANCE_NAME --format='get(zone)')

REGION=$(echo $ZONE | sed 's/-[^-]*$//')


gcloud compute ssh lab-setup --zone=$ZONE --project=$DEVSHELL_PROJECT_ID --quiet --command="git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git && cd python-docs-samples/appengine/standard_python3/hello_world"

gcloud app browse



