# Azure DevOps & Jenkins CI service setting
###### tags: `CI` `jenkins` `docker`
### Basic Flow
* Jenkins
    * [Install docker jenkins](https://www.jenkins.io/doc/book/installing/#docker)
* Docker private registry
    * [Install docker private registry](https://docs.docker.com/registry/deploying/)

![](https://i.imgur.com/2eBzxW5.png)


### 前情提要
* jenkins & docker private registry 皆使用 docker image來建立服務
* jenkins 使用了 Docker-in-Docker / privileged container 的概念
    * [簡介](https://medium.com/swlh/quickstart-ci-with-jenkins-and-docker-in-docker-c3f7174ee9ff)
    * [Docker-in-Docker 優缺](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
    * [Docker-in-Docker 特權容器 (privileged container)](https://blog.trendmicro.com.tw/?p=62986)
* docker private registry 使用 Restricting access with self sign cert (https)
    * [Doc](https://docs.docker.com/registry/deploying/#restricting-access)
---
### Docker jenkins
#### To build jenkins as root


jenkins 官方所提供的docker image 是 privileged mode docker, 在此環境中擁有主機完整系統權限 (root), 在進入docker jenkins 後發現身分非root, 而是jenkins, 但為了要讓 jenkins 與使用了Self-Signed Certificate的private registry互動, 會動用到 root 權限在docker in docker 的環境中匯入自簽憑證.

因此透過Ddockerfile 自己 build image,在 build image 時,以 root 的身分加入registry ca cert 執行 `update-ca-certificates`.
* [Rootless mode 官方文件](https://docs.docker.com/engine/security/rootless/)
#### 2張組成 jenkins docker ver. 服務的images
* jenkins-docker 
    * Docker-in-Docker 特權容器
* jenkinsci/blueocean 
    * 提供jenkins服務於jenkins-docker之中(or 之上?)

![](https://i.imgur.com/eMQr4o1.png)


---
### Docker image CI
#### Push Image Flow
![](https://i.imgur.com/lEEzF9L.png)


#### Let your jenkins access your repo

![](https://i.imgur.com/Y4dFW2N.png)

#### Trigger jenkins to build image after code push
驗證 token

![](https://i.imgur.com/p5Corz0.png)

#### Build image scripts and push to private registry
![](https://i.imgur.com/fmMDJqE.png)



---
### Azure service hooks setting
![](https://i.imgur.com/UbyJ3II.png)

### New service hook subscription
* select a repository

![](https://i.imgur.com/7DeRBgc.png)

* User API token : 從 jenkins 產生

![](https://i.imgur.com/uBWTAB0.png)

![](https://i.imgur.com/dblCNcX.png)
* Jenkins bash URL (where is your jenkins)
* User name : the name you login to jenkins
* User API token : 從 jenkins 產生

![](https://i.imgur.com/4Ib6OVE.png)

* Build token : 驗證 token(你自己知道的通關密語)
* Build : Jenkins 作業

![](https://i.imgur.com/vHOhcUc.png)

* test

![](https://i.imgur.com/09sZ6Nx.png)


