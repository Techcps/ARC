
gcloud compute firewall-rules create default-allow-outbound --direction=EGRESS --priority=1000 --network=default --action=ALLOW --rules=all --destination-ranges=0.0.0.0/0
