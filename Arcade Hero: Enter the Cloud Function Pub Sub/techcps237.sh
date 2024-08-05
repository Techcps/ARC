

gcloud auth list

gcloud config set compute/region $REGION

export PROJECT_ID=$DEVSHELL_PROJECT_ID


export PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects list --filter="project_id:$PROJECT_ID" --format='value(project_number)')

git clone https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git
cd nodejs-docs-samples/functions/v2/helloPubSub/

gcloud functions deploy cf-demo \
--gen2 \
--runtime=nodejs20 \
--region=$REGION \
--source=. \
--entry-point=helloPubSub \
--trigger-topic=cf_topic \
--quiet



sleep 30

#!/bin/bash

export SERVICE_NAME=cf-demo


deploy_function() {
  gcloud functions deploy $SERVICE_NAME \
  --gen2 \
  --runtime=nodejs20 \
  --region=$REGION \
  --source=. \
  --entry-point=helloPubSub \
  --trigger-topic=cf_topic --quiet
  }
  
  deploy_success=false
  
  while [ "$deploy_success" = false ]; do
    if deploy_function; then
      echo "Function deployed successfully (https://www.youtube.com/@techcps).."
      deploy_success=true
    else
      echo "please subscribe to techcps (https://www.youtube.com/@techcps)."
      sleep 10
    fi
  done  
  
  
  echo "Congratulations, you're all done with the lab"
  echo "Please like share and subscribe to techcps(https://www.youtube.com/@techcps)..."
  
  
