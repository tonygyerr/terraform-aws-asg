#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo yum install -y git

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo amazon-linux-extras install python3

cd /opt
# We need setup git credentials before this command

mkdir -p .ssh
ssh-keyscan -t rsa bitbucket.org > .ssh/known_hosts
cd BragHouse-Django-Backend
git checkout main
# Should setup ec2 access to the s3 bucket
aws s3 cp s3://braghouse-django-prod/configs/prod.env .

make prod.create_cert_shared_dirs
make prod.migrate

make prod.up