
gcloud config set compute/region $REGION

gsutil mb -c coldline gs://$DEVSHELL_PROJECT_ID-bucket

gsutil retention set 30s gs://$DEVSHELL_PROJECT_ID-gcs-bucket

gsutil mb gs://$DEVSHELL_PROJECT_ID-bucket-ops

gsutil cp -a public-read sample.txt gs://$DEVSHELL_PROJECT_ID-bucket-ops/sample.txt
echo "subscribe to techcps" | gsutil -h "Content-Type:text/plain" -h "Cache-Control:public, max-age=0" cp - gs://$DEVSHELL_PROJECT_ID-bucket-ops/sample.txt

gsutil defstorageclass set archive gs://Bucket3

