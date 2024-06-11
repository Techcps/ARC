
# Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps) & join our [WhatsApp Community](https://whatsapp.com/channel/0029Va9nne147XeIFkXYv71A)

## TASK 1:

```
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
```

```
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh --also-install
```

```
(cd /etc/stackdriver/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/apache.conf)
```

```
sudo service stackdriver-agent restart
```

```
timeout 120 bash -c -- 'while true; do curl localhost | grep -oP ".*"; sleep .1s;done '
```

## TASK 5
## Make sure to replace your project id 
```
resource.type="gce_instance"
logName="projects/ENTER_YOUR_PROJECT_ID/logs/apache-access"
textPayload:"200"
```

## Congratulations, you're all done with the lab 😄

# Thanks for watching :)
