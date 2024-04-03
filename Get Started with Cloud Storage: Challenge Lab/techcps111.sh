# Get the form number from the from input
read -p "Enter the Form number (1, 2, or 3): " form_number

# Function to run Form 1
cp_form_1() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -p $BUCKET gs://$BUCKET-bucket

gsutil retention set 30s gs://$BUCKET-gcs-bucket

echo "subscibe to quicklab" > sample.txt

gsutil cp sample.txt gs://$BUCKET-bucket-ops/
}

# Function to run Form 2
cp_form_2() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -c nearline gs://$BUCKET-bucket

gcloud alpha storage buckets update gs://$BUCKET-gcs-bucket --no-uniform-bucket-level-access

gsutil acl ch -u $USER_EMAIL:OWNER gs://$BUCKET-gcs-bucket

gsutil rm gs://$BUCKET-gcs-bucket/sample.txt

echo "subscibe to quicklab" > sample.txt

gsutil cp sample.txt gs://$BUCKET-gcs-bucket

gsutil acl ch -u allUsers:R gs://$BUCKET-gcs-bucket/sample.txt

gcloud storage buckets update gs://$BUCKET-bucket-ops --update-labels=key=value
}

# Function to run Form 3
cp_form_3() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -c coldline gs://$BUCKET-bucket

echo "This is an example of editing the file content for cloud storage object" | gsutil cp - gs://$BUCKET-gcs-bucket/sample.txt

gsutil defstorageclass set ARCHIVE gs://$BUCKET-bucket-ops
}

# Run the function based on the selected form number
case $form_number in
    1) 
        cp_form_1 || run_form_2 ;;
    2) 
        cp_form_2 || run_form_3 ;;
    3) 
        cp_form_3 ;;
    *) 
        echo "CP Invalid form number. Please enter 1, 2, or 3." ;;
esac
