gcloud compute instances create reddit-app5 \
    --image  reddit-full-1584780929  \
    --machine-type=f1-micro \
    --restart-on-failure \
    --tags puma-server
