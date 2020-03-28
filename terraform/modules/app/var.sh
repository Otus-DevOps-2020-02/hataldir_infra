#sudo bash -c "echo \"DATABASE_URL=$1\">>/etc/environment"
sed -i "s/changeme/$1/" /tmp/puma.service
