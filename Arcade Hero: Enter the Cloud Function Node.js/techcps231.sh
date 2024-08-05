
gcloud auth list
gcloud config set compute/region $REGION

export PROJECT_ID=$DEVSHELL_PROJECT_ID


mkdir techcps && cd techcps

# Create index.js with the function code
cat > index.js <<'EOF_CP'
const functions = require('@google-cloud/functions-framework');

// Register an HTTP function with the Functions Framework that will be executed
// when you make an HTTP request to the deployed function's endpoint.
functions.http('helloGET', (req, res) => {
  res.send('Hello from Cloud Functions!');
});
EOF_CP

# Create package.json with dependencies
cat > package.json <<'EOF_CP'
{
  "dependencies": {
    "@google-cloud/functions-framework": "^3.1.0"
  }
}
EOF_CP

sleep 15

deploy_function() {
  gcloud functions deploy cf-demo \
    --gen2 \
    --runtime=nodejs20 \
    --entry-point helloGET \
    --region=$REGION \
    --source=. \
    --trigger-http \
    --allow-unauthenticated --quiet
}

deploy_success=false
while [ "$deploy_success" = false ]; do
  if deploy_function; then
    echo "Function deployed successfully."
    deploy_success=true
  else
    echo "Deployment failed. Retrying..."
    sleep 10
  fi
done


echo "Congratulations, you're all done with the lab"
echo "Please like share and subscribe to techcps(https://www.youtube.com/@techcps)..."

