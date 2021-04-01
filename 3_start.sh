docker container run \
  --name jenkins-docker \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --env DOCKER_TLS_VERIFY=0 \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --volume /etc/hosts:/etc/hosts \
  --volume /etc/docker:/etc/docker \
  --publish 2376:2376 \
  docker/jenkins

docker container run \
  --user 1000 \
  --name jenkins-blueocean \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=0 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --volume /etc/hosts:/etc/hosts \
  --volume /etc/docker:/etc/docker \
  jenkinsci/blueocean