
gsutil mb gs://$DEVSHELL_PROJECT_ID-bucket

gsutil retention set 30s gs://$DEVSHELL_PROJECT_ID-gcs-bucket

echo "Hello, CP Cloud Storage!" > hello.txt
gsutil cp hello.txt gs://$DEVSHELL_PROJECT_ID-bucket-ops/

