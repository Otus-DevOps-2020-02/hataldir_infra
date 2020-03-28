sudo sed -i "s/bindIp/#bindIp/" /etc/mongod.conf
sudo systemctl restart mongod
