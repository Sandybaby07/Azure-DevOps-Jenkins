# Docker Jenkins Setup
###### tags: `CI` `jenkins` `docker`

![Sherlock](https://www.jenkins.io/images/logos/sherlock/sherlock.png =200x)
##### Official Doc : [Install docker jenkins](https://www.jenkins.io/doc/book/installing/#docker)
---
#### Step 1 prepare

==ca.crt==
```
prepare your registry cert
```
#### Step 2
```
./1_build.sh
./2_create_net.sh
./3_start.sh
```
#### Step 3
```
#add registry address to /etc/hosts
echo'x.x.x.x myregistry.com'>>/etc/hosts

#set password for root user
sudo passwd root

#as root user
su -

#build image
./build

#creat network
./creat_net

#start service
./start
```

#### Step 4
```
#enter docker container
docker exec -it jenkins-blueocean bash

#in container
docker login myregistry.com
```

Ref !!!!!!!
https://www.edureka.co/community/55640/jenkins-docker-docker-image-jenkins-pipeline-docker-registry