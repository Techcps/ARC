


gcloud auth list

gcloud config set project $DEVSHELL_PROJECT_ID


cat > redact-request.json <<EOF_CP
{
	"item": {
		"value": "Please update my records with the following information:\n Email address: foo@example.com,\nNational Provider Identifier: 1245319599"
	},
	"deidentifyConfig": {
		"infoTypeTransformations": {
			"transformations": [{
				"primitiveTransformation": {
					"replaceWithInfoTypeConfig": {}
				}
			}]
		}
	},
	"inspectConfig": {
		"infoTypes": [{
				"name": "EMAIL_ADDRESS"
			},
			{
				"name": "US_HEALTHCARE_NPI"
			}
		]
	}
}
EOF_CP


curl -s \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$DEVSHELL_PROJECT_ID/content:deidentify \
  -d @redact-request.json -o redact-response.txt


gsutil cp redact-response.txt gs://$BUCKET_NAME


echo "Please subscribe to techcps[https://www.youtube.com/@techcps]"

echo "Click the below link"

echo "-------------"

echo "Click here to open the link https://console.cloud.google.com/security/sensitive-data-protection/landing/configuration/templates/inspect?cloudshell=true&project=$DEVSHELL_PROJECT_ID"

