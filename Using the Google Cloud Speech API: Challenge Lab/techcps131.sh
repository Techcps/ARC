

cat > "$REQUEST_CP2" <<EOF
{
  "config": {
    "encoding": "LINEAR16",
    "languageCode": "en-US",
    "audioChannelCount": 2
  },
  "audio": {
    "uri": "gs://spls/arc131/question_en.wav"
  }
}
EOF


curl -s -X POST -H "Content-Type: application/json" --data-binary @"$REQUEST_CP2" \
"https://speech.googleapis.com/v1/speech:recognize?key=$API_KEY" > $RESPONSE_CP2



cat > "$REQUEST_SP_CP3" <<EOF
{
  "config": {
    "encoding": "FLAC",
    "languageCode": "es-ES"
  },
  "audio": {
    "uri": "gs://spls/arc131/multi_es.flac"
  }
}
EOF



curl -s -X POST -H "Content-Type: application/json" --data-binary @"$REQUEST_SP_CP3" \
"https://speech.googleapis.com/v1/speech:recognize?key=$API_KEY" > $RESPONSE_SP_CP3



