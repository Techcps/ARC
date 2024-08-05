

gcloud auth list

gcloud config set compute/region $REGION

export PROJECT_ID=$DEVSHELL_PROJECT_ID

mkdir techcps && cd techcps


cat > index.php <<'EOF_CP'
<?php
use Google\CloudFunctions\FunctionsFramework;
use Psr\Http\Message\ServerRequestInterface;

FunctionsFramework::http('helloHttp', 'helloHttp');

function helloHttp(ServerRequestInterface $request): string
{
  $name = 'World';
  $body = $request->getBody()->getContents();
  if (!empty($body)) {
    $json = json_decode($body, true);
    if (json_last_error() != JSON_ERROR_NONE) {
      throw new RuntimeException(sprintf(
        'Could not parse body: %s',
        json_last_error_msg()
      ));
    }
    $name = $json['name'] ?? $name;
  }
  $queryString = $request->getQueryParams();
  $name = $queryString['name'] ?? $name;

  return sprintf('Hello, %s!', htmlspecialchars($name));
}
EOF_CP


cat > composer.json <<EOF_CP
{
   "require": {
       "google/cloud-functions-framework": "^1.1"
   }
}
EOF_CP

sleep 15

#!/bin/bash

deploy_function() {
    gcloud functions deploy cf-demo \
    --gen2 \
    --runtime=php82 \
    --entry-point helloHttp \
    --source . \
    --region=$REGION \
    --trigger-http \
    --allow-unauthenticated --quiet
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
  
  
