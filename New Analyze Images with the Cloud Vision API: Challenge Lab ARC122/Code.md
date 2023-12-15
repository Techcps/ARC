
#  Analyze Images with the Cloud Vision API: Challenge Lab [ARC122]

# Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps)

* In the GCP Console open the Cloud Shell and enter the following commands:

```
gcloud alpha services api-keys create --display-name="techcps" 
KEY_NAME=$(gcloud alpha services api-keys list --format="value(name)" --filter "displayName=techcps")
export API_KEY=$(gcloud alpha services api-keys get-key-string $KEY_NAME --format="value(keyString)")

sudo chmod +x techcpsarc122.sh
./techcpsarc122.sh
```

# Congratulations, you're all done with the lab 😄

# Thanks for watching :)
