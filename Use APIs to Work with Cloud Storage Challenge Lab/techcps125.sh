

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



curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" \
 -H "Content-Type: image/jpeg" --data-binary @cpmap.jpeg \
 "https://storage.googleapis.com/upload/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o?uploadType=media&name=techcps.jpeg"


curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" \
 -H "Content-Type: application/json" --data '{"destination": "$DEVSHELL_PROJECT_ID-bucket-2"}' \
 "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/techcps.jpeg/copyTo/b/$DEVSHELL_PROJECT_ID-bucket-2/o/techcps.jpeg"




cat > public.json << EOF_CP
{
  "entity": "allUsers",
  "role": "READER"
}
EOF_CP


curl -X POST --data-binary @public.json -H "Authorization: Bearer $(gcloud auth print-access-token)" \
 -H "Content-Type: application/json" \
 "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/techcps.jpeg/acl"




curl -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
"https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/techcps.jpeg"


curl -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
"https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1"



