

gcloud auth list

cat > bucket1.json << EOF_CP
{
   "name": "$DEVSHELL_PROJECT_ID-bucket-1",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF_CP


curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
     -d @bucket1.json \
     "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"



cat > bucket2.json << EOF_CP
{
   "name": "$DEVSHELL_PROJECT_ID-bucket-2",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF_CP


curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
     -d @bucket2.json \
     "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"


