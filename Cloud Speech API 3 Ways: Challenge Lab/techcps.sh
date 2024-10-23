# ARC132!


gcloud auth list

export ZONE=$(gcloud compute instances list lab-vm --format 'csv[no-heading](zone)')

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

echo "Please export the values correctly."


# Enter the variable name correctly
read -p "Enter API_KEY: " API_KEY
read -p "Enter file_cp2: " file_cp2
read -p "Enter request_cp3: " request_cp3
read -p "Enter response_cp3: " response_cp3
read -p "Enter sentence_cp4: " sentence_cp4
read -p "Enter file_cp4: " file_cp4
read -p "Enter sentence_cp5: " sentence_cp5
read -p "Enter file_cp5: " file_cp5


cat > cp_disk.sh <<'EOF_CP'

cp="gs://cloud-samples-data/speech/corbeau_renard.flac"

export PROJECT_ID=$(gcloud config get-value project)

source venv/bin/activate


cat > synthesize-text.json <<EOF

{
'input':{
   'text':'Cloud Text-to-Speech API allows developers to include
      natural-sounding, synthetic human speech as playable audio in
      their applications. The Text-to-Speech API converts text or
      Speech Synthesis Markup Language (SSML) input into audio data
      like MP3 or LINEAR16 (the encoding used in WAV files).'
},
'voice':{
   'languageCode':'en-gb',
   'name':'en-GB-Standard-A',
   'ssmlGender':'FEMALE'
},
'audioConfig':{
   'audioEncoding':'MP3'
}
}

EOF


curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
-H "Content-Type: application/json; charset=utf-8" \
-d @synthesize-text.json "https://texttospeech.googleapis.com/v1/text:synthesize" \
> $file_cp2


cat > "$request_cp3" <<EOF
{
"config": {
"encoding": "FLAC",
"sampleRateHertz": 44100,
"languageCode": "fr-FR"
},
"audio": {
"uri": "$cp"
}
}
EOF


curl -s -X POST -H "Content-Type: application/json" \
--data-binary @"$request_cp3" \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" \
-o "$response_cp3"


response=$(curl -s -X POST \
-H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d "{\"q\": \"$sentence_cp4\"}" \
"https://translation.googleapis.com/language/translate/v2?key=${API_KEY}&source=ja&target=en")
echo "$response" > "$file_cp4"


curl -s -X POST \
-H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
-d "{\"q\": [\"$sentence_cp5\"]}" \
"https://translation.googleapis.com/language/translate/v2/detect?key=${API_KEY}" \
-o "$file_cp5"
EOF_CP


gcloud compute scp cp_disk.sh lab-vm:/tmp --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet

gcloud compute ssh lab-vm --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet --command="bash /tmp/cp_disk.sh"


