

# Get the form number from the from input
read -p "Enter the Form number (1, 2, 3 or 4): " form_number

# Function to run Form 1
cp_form_1() {
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

gcloud config set compute/zone $ZONE

export REGION=${ZONE%-*}
gcloud config set compute/region $REGION


export KEY_1=domain_type
export VALUE_1=source_data

gsutil mb -p $DEVSHELL_PROJECT_ID -l $REGION -b on gs://$DEVSHELL_PROJECT_ID-bucket/

gcloud alpha dataplex lakes create customer-lake --project=$DEVSHELL_PROJECT_ID --location=$REGION --labels="key_1=$KEY_1,value_1=$VALUE_1" --display-name="Customer-Lake"

gcloud dataplex zones create public-zone --project=$DEVSHELL_PROJECT_ID  --location=$REGION --lake=customer-lake --type=RAW --resource-location-type=SINGLE_REGION --display-name="Public-Zone"

gcloud dataplex environments create dataplex-lake-env --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --os-image-version=1.0 --compute-node-count 3 --compute-max-node-count 3

gcloud data-catalog tag-templates create customer_data_tag_template --project=$DEVSHELL_PROJECT_ID --location=$REGION --display-name="Customer Data Tag Template" --field=id=data_owner,display-name="Data Owner",type=string,required=TRUE --field=id=pii_data,display-name="PII Data",type='enum(Yes|No)',required=TRUE
}

# Function to run Form 2
cp_form_2() {
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

gcloud config set compute/zone $ZONE

export REGION=${ZONE%-*}
gcloud config set compute/region $REGION

export KEY_1=domain_type
export VALUE_1=source_data

gcloud alpha dataplex lakes create customer-lake --project=$DEVSHELL_PROJECT_ID --location=$REGION --labels="key_1=$KEY_1,value_1=$VALUE_1" --display-name="Customer-Lake"

gcloud dataplex zones create public-zone --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --type=RAW --resource-location-type=SINGLE_REGION --display-name="Public-Zone"

gcloud dataplex environments create dataplex-lake-env --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --os-image-version=1.0 --compute-node-count 3  --compute-max-node-count 3

gcloud dataplex assets create customer-raw-data --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --zone=public-zone --resource-type=STORAGE_BUCKET --resource-name=projects/$DEVSHELL_PROJECT_ID/buckets/$DEVSHELL_PROJECT_ID-customer-bucket --discovery-enabled --display-name="Customer Raw Data"

gcloud dataplex assets create customer-reference-data --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --zone=public-zone --resource-type=BIGQUERY_DATASET --resource-name=projects/$DEVSHELL_PROJECT_ID/datasets/customer_reference_data --display-name="Customer Reference Data"

gcloud data-catalog tag-templates create customer_data_tag_template --project=$DEVSHELL_PROJECT_ID --location=$REGION --display-name="Customer Data Tag Template" --field=id=data_owner,display-name="Data Owner",type=string,required=TRUE --field=id=pii_data,display-name="PII Data",type='enum(Yes|No)',required=TRUE
}

# Function to run Form 3
cp_form_3() {
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

gcloud config set compute/zone $ZONE

export REGION=${ZONE%-*}
gcloud config set compute/region $REGION

bq mk --location=US Raw_data

bq load --source_format=AVRO Raw_data.public-data gs://spls/gsp1145/users.avro

gcloud dataplex zones create temperature-raw-data --project=$DEVSHELL_PROJECT_ID --lake=public-lake --location=$REGION --type=RAW --resource-location-type=SINGLE_REGION --display-name="temperature-raw-data"

gcloud dataplex assets create customer-details-dataset --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=public-lake --zone=temperature-raw-data --resource-type=BIGQUERY_DATASET --resource-name=projects/$DEVSHELL_PROJECT_ID/datasets/customer_reference_data --discovery-enabled --display-name="Customer Details Dataset"

gcloud data-catalog tag-templates create protected_data_template --project=$DEVSHELL_PROJECT_ID --location=$REGION --display-name="Protected Data Template" --field=id=protected_data_flag,display-name="Protected Data Flag",type='enum(Yes|No)',required=TRUE
}

# Function to run Form 4
cp_form_4() {
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

gcloud config set compute/zone $ZONE

export REGION=${ZONE%-*}
gcloud config set compute/region $REGION

export KEY_1=domain_type

export VALUE_1=source_data


gcloud alpha dataplex lakes create customer-lake --project=$DEVSHELL_PROJECT_ID --display-name="Customer-Lake" --location=$REGION --labels="key_1=$KEY_1,value_1=$VALUE_1"

gcloud dataplex zones create public-zone --project=$DEVSHELL_PROJECT_ID --lake=customer-lake --location=$REGION --type=RAW --resource-location-type=SINGLE_REGION --display-name="Public-Zone"

gcloud dataplex assets create customer-raw-data --project=$DEVSHELL_PROJECT_ID --location=$REGION --lake=customer-lake --zone=public-zone --resource-type=STORAGE_BUCKET --resource-name=projects/$DEVSHELL_PROJECT_ID/buckets/$DEVSHELL_PROJECT_ID-customer-bucket --discovery-enabled --display-name="Customer Raw Data"

gcloud dataplex assets create customer-reference-data --project=$DEVSHELL_PROJECT_ID --location=$REGION --zone=public-zone --resource-type=BIGQUERY_DATASET --lake=customer-lake --resource-name=projects/$DEVSHELL_PROJECT_ID/datasets/customer_reference_data --display-name="Customer Reference Data"
}


# Run the function based on the selected form number
case $form_number in
    1) 
        cp_form_1 ;;
    2) 
        cp_form_2 ;;
    3) 
        cp_form_3 ;;
    4) 
        cp_form_4 ;;
    *) 
        echo "Invalid form number. Please enter 1, 2, 3, or 4." ;;
esac

