

gcloud auth list

gcloud config set compute/region $REGION

export PROJECT_ID=$DEVSHELL_PROJECT_ID

mkdir techcps && cd techcps


cat > main.py <<'EOF_CP'
import functions_framework

@functions_framework.http
def hello_http(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    """
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and 'name' in request_json:
        name = request_json['name']
    elif request_args and 'name' in request_args:
        name = request_args['name']
    else:
        name = 'World'
    return 'Hello {}!'.format(name)
EOF_CP


cat > requirements.txt <<EOF_CP
functions-framework==3.*
EOF_CP


sleep 15

#!/bin/bash

deploy_function() {
gcloud functions deploy cf-demo \
  --gen2 \
  --runtime=python312 \
  --entry-point=hello_http \
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
  
  
