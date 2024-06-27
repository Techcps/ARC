

# Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps) & join our [WhatsApp Community](https://whatsapp.com/channel/0029Va9nne147XeIFkXYv71A)


## 🚨 Export the REGION  name correctly

```
export REGION=us-east4
```

```
gcloud services enable appengine.googleapis.com
sleep 5
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd python-docs-samples/appengine/standard_python3/hello_world
gcloud app create --region=$REGION
gcloud app deploy --quiet
```

## 🚨Check if your region/zone name is correct, If it is type 'Y' and if not then type 'N'
 ![techcps](https://github.com/Techcps/ARC/assets/104138529/385aa9e3-9865-47ee-bcf6-7c10d9c14942)

```
INSTANCE_NAME=lab-setup
ZONE=$(gcloud compute instances describe $INSTANCE_NAME --format='get(zone)')
REGION=$(echo $ZONE | sed 's/-[^-]*$//')
gcloud compute ssh lab-setup --zone=$ZONE --project=$DEVSHELL_PROJECT_ID --quiet
```

```
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd python-docs-samples/appengine/standard_python3/hello_world
```

# 🚨 Type exit to returm cloud shell

## 🚨 Replace your message

```
sed -i 's/Hello World!/REPLACE_YOUR_MESSAGE/g' main.py
```

## 🚨 Now run the below commands

```
gcloud app deploy --quiet
```

## Congratulations, you're all done with the lab 😄

# Thanks for watching :)
