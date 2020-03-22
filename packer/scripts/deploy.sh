#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install

sudo cat << EOF > /etc/systemd/system/puma.service

[Unit]
Description=Puma
After=syslog.target
After=network.target
Requires=mongod.service

[Service]
Type=simple
PIDFile=/var/tmp/puma.pid
WorkingDirectory=/home/appuser/reddit

User=root
Group=root



ExecStart=/usr/local/bin/puma

TimeoutSec=300

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl enable puma
