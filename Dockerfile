FROM docker:19.03-dind
USER root
ADD ca.crt /usr/local/share/ca-certificates/sandy.registry.com.crt
RUN update-ca-certificates