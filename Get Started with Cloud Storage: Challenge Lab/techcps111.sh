

# Get the form number from the from input
read -p "Enter the Form number (1, 2, or 3): " form_number

# Function to run Form 1
cp_form_1() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -c coldline gs://$BUCKET_1

gsutil retention set 30s gs://$BUCKET_2

echo "please subscibe to techcps" > sample.txt

gsutil cp sample.txt gs://$BUCKET_3/
}

# Function to run Form 2
cp_form_2() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -c nearline gs://$BUCKET_1

gcloud alpha storage buckets update gs://$BUCKET_2 --no-uniform-bucket-level-access

gsutil acl ch -u $USER_EMAIL:OWNER gs://$BUCKET_2

gsutil rm gs://$BUCKET_2/sample.txt

echo "please subscibe to techcps" > sample.txt

gsutil cp sample.txt gs://$BUCKET_2

gsutil acl ch -u allUsers:R gs://$BUCKET_2/sample.txt

gcloud storage buckets update gs://$BUCKET_3 --update-labels=key=value
}

# Function to run Form 3
cp_form_3() {
export BUCKET="$(gcloud config get-value project)"		

gsutil mb -c nearline gs://$BUCKET_1


# Create a sample file with content
echo "This is an example of editing the file content for cloud storage object" > sample.txt

# Upload the file to the specified bucket
gsutil cp sample.txt gs://$BUCKET_2

gsutil defstorageclass set ARCHIVE gs://$BUCKET_3
}


echo "Please set the below values correctly"

# Export the buckets name correctly
read -p "Enter the BUCKET_1: " BUCKET_1
read -p "Enter the BUCKET_2: " BUCKET_2
read -p "Enter the BUCKET_3: " BUCKET_3

# Run the function based on the selected form number
case $form_number in
    1) 
        cp_form_1 || cp_form_2 ;;
    2) 
        cp_form_2 || cp_form_3 ;;
    3) 
        cp_form_3 ;;
    *) 
        echo "CP Invalid form number. Please enter 1, 2, or 3." ;;
esac
