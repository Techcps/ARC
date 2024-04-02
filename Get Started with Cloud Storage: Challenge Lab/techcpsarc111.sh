
gsutil mb gs://$BUCKET-bucket

gsutil retention set 30s gs://$BUCKET2-gcs-bucket

echo "Hello, CP Cloud Storage!" > hello.txt
gsutil cp hello.txt gs://$BUCKET3-bucket-ops/

