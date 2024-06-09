

# Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps) & join our [WhatsApp Community](https://whatsapp.com/channel/0029Va9nne147XeIFkXYv71A)

## Tap here to open [Online Notepad](https://www.rapidtables.com/tools/notepad.html#)

## 🚨 Export the below variables name correctly:
```
API_KEY=""

file_cp2=""

request_cp3=""

response_cp3=""

sentence_cp4=""

file_cp4=""

sentence_cp5=""

file_cp5=""
```

## 🚨

```
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



cat > tts_decode.py <<EOF
import argparse
from base64 import decodebytes
import json
"""
Usage:
        python tts_decode.py --input "synthesize-text.txt" \
        --output "synthesize-text-audio.mp3"
"""
def decode_tts_output(input_file, output_file):
    """ Decode output from Cloud Text-to-Speech.
    input_file: the response from Cloud Text-to-Speech
    output_file: the name of the audio file to create
    """
    with open(input_file) as input:
        response = json.load(input)
        audio_data = response['audioContent']
        with open(output_file, "wb") as new_file:
            new_file.write(decodebytes(audio_data.encode('utf-8')))
if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Decode output from Cloud Text-to-Speech",
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--input',
                       help='The response from the Text-to-Speech API.',
                       required=True)
    parser.add_argument('--output',
                       help='The name of the audio file to create',
                       required=True)
    args = parser.parse_args()
    decode_tts_output(args.input, args.output)
EOF

python tts_decode.py --input "$file_cp2" --output "synthesize-text-audio.mp3"





audio_uri="gs://cloud-samples-data/speech/corbeau_renard.flac"


cat > "$request_cp3" <<EOF
{
  "config": {
    "encoding": "FLAC",
    "sampleRateHertz": 44100,
    "languageCode": "fr-FR"
  },
  "audio": {
    "uri": "$audio_uri"
  }
}
EOF


curl -s -X POST -H "Content-Type: application/json" \
    --data-binary @"$request_cp3" \
    "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" \
    -o "$response_cp3"



sudo apt-get update
sudo apt-get install -y jq

curl "https://translation.googleapis.com/language/translate/v2?target=en&key=${API_KEY}&q=${sentence_cp4}" > $file_cp4

curl "https://translation.googleapis.com/language/translate/v2?target=en&key=${API_KEY}&q=${task_4_sentence}" > $task_4_file

decoded_sentence=$(python -c "import urllib.parse; print(urllib.parse.unquote('$sentence_cp5'))")


curl -s -X POST \
  -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"q\": [\"$decoded_sentence\"]}" \
  "https://translation.googleapis.com/language/translate/v2/detect?key=${API_KEY}" \
  -o "$file_cp5"
```

## Congratulations, you're all done with the lab 😄

# Thanks for watching :)
