
gsutil mb gs://$BUCKET

gsutil retention set 30s gs://$BUCKET2

echo "Hello, CP Cloud Storage!" > hello.txt
gsutil cp hello.txt gs://$BUCKET3/

