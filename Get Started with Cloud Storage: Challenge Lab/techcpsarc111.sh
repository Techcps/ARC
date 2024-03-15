
gsutil mb -c coldline gs://$DEVSHELL_PROJECT_ID-bucket

# gsutil mb gs://$DEVSHELL_PROJECT_ID-gcs-bucket

gsutil cp -a public-read sample.txt gs://$DEVSHELL_PROJECT_ID-gcs-bucket/sample.txt
echo "This is an example of editing the file content for cloud storage object" | gsutil -h "Content-Type:text/plain" -h "Cache-Control:public, max-age=0" cp - gs://$DEVSHELL_PROJECT_ID-gcs-bucket/sample.txt

# gsutil mb gs://$DEVSHELL_PROJECT_ID-bucket-ops

gsutil defstorageclass set archive gs://$DEVSHELL_PROJECT_ID-bucket-ops
