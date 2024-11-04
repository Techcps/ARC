
## 💡 Lab Link: [Create a Secure Data Lake on Cloud Storage: Challenge Lab - ARC119](https://www.cloudskillsboost.google/focuses/63857?parent=catalog)

## 🚀 Lab Solution [Watch Here](https://youtu.be/PbIfliCwHQw)

---

### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**

### ©Credit
- **DM for credit or removal request (no copyright intended) ©All rights and credits for the original content belong to Google Cloud [Google Cloud Skill Boost website](https://www.cloudskillsboost.google/)** 🙏

---

## 🚨Export the ZONE Name correctly
```
export ZONE=
```

## 🚨Copy and run the below commands in Cloud Shell:

```
curl -LO raw.githubusercontent.com/Techcps/ARC/master/Create%20a%20Secure%20Data%20Lake%20on%20Cloud%20Storage%3A%20Challenge%20Lab/techcps119.sh
sudo chmod +x techcps119.sh
./techcps119.sh
```

## 💡 CP Invalid form number. Please enter 1, 2, 3, or 4: 

---

## 💡 Let's find the Form Number: Press Ctrl + G

---

### 🚀 Form 1

- **Task 1. Create a Cloud Storage bucket**
- **Task 2. Create a lake in Dataplex and add a zone to your lake**
- **Task 3. Environment Creation for Dataplex Lake**
- **Task 4. Create a tag template**

---

### 🚀 Form 2

- **Task 1. Create a lake in Dataplex and add a zone to your**
- **Task 2. Environment Creation for Dataplex**
- **Task 3. Attach an existing Cloud Storage bucket to the zone**
- **Task 4. Create a tag template**

---

### 🚀 Form 3

- **Task 1. Create a BigQuery dataset**
- **Task 2. Add a zone to your lake**
- **Task 3. Attach an existing BigQuery Dataset to the Lake**
- **Task 4. Create a tag template**

---

### 🚀 Form 4

- **Task 1. Create a lake in Dataplex and add a zone to your lake**
- **Task 2. Attach an existing Cloud Storage bucket to the zone**
- **Task 3. Attach an existing BigQuery Dataset to the Lake**
- **Task 4. Create Entities**

---

- **Task: Create an entry group**
```
# Export the Region name correctly
read -p "Enter the REGION: " REGION

ENTRY_GROUP_ID="custom_entry_group"

gcloud data-catalog entry-groups create $ENTRY_GROUP_ID --location=$REGION --display-name="Custom entry group" && gcloud data-catalog entry-groups list --location=$REGION
```

### Congratulations, you're all done with the lab 😄
---

### 🌐 Join our Community

- **Join our [Discussion Group](https://t.me/Techcpschat)** <img src="https://github.com/user-attachments/assets/a4a4b767-151c-461d-bca1-da6d4c0cd68a" alt="icon" width="25" height="25">
- **Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps)** <img src="https://github.com/user-attachments/assets/6ee41001-c795-467c-8d96-06b56c246b9c" alt="icon" width="25" height="25">
- **Join our [WhatsApp Community](https://whatsapp.com/channel/0029Va9nne147XeIFkXYv71A)** <img src="https://github.com/user-attachments/assets/aa10b8b2-5424-40bc-8911-7969f29f6dae" alt="icon" width="25" height="25">
- **Join our [Telegram Channel](https://t.me/Techcps)** <img src="https://github.com/user-attachments/assets/a4a4b767-151c-461d-bca1-da6d4c0cd68a" alt="icon" width="25" height="25">
- **Follow us on [LinkedIn](https://www.linkedin.com/company/techcps/)** <img src="https://github.com/user-attachments/assets/b9da471b-2f46-4d39-bea9-acdb3b3a23b0" alt="icon" width="25" height="25">

### Thanks for watching :)
