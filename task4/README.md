### 1. Bash script for installing Docker.  
  
The script ``install-docker.sh`` contain list of commands:  
1 - ``sudo yum update -y`` - Update the installed packages and package cache on your instance.  
2 - ``sudo yum -y install docker`` - Install the most recent Docker Engine package.  
3 - ``sudo service docker start`` -  Start the Docker service.  
4 - ``sudo usermod -a -G docker ec2-user`` - Add the ec2-user to the docker group so you can execute Docker commands without using sudo.  
5 - ``docker version`` - Check installed docker version.  
6 - ``service docker status`` - Check docker status.  
7 - ``docker pull hello-world`` - Download the image to local repository.  
8 - ``docker run hello-world`` - Run any docker container "hello world".  

### 2. An mage created with html page, with text <Username> Sandbox 2021  
  
###### Dockerfile consists of below scripts
``FROM ubuntu:18.04``

###### Install dependencies
``RUN apt-get update && \``  
``apt-get -y install apache2``  
  
###### Install apache and write hello world message  
``RUN echo "$(whoami) Sandbox 2021" > /var/www/html/index.html``  

###### Configure apache  
``RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \``  
 ``echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \``  
 ``echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \``  
 ``echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \``  
 ``chmod 755 /root/run_apache.sh``  

``EXPOSE 80``  
  
``CMD /root/run_apache.sh``  
###### To run script build the Docker image from your Dockerfile.  
``docker build -t hello-world .``  
###### Run the newly built image. 
``docker run -t -i -p 80:80 hello-world``  
###### Open a browser and point to the server that is running Docker and hosting your container. If you are using an EC2 instance, this is the Public DNS  
    
### 3. Dockerfile for building a docker image. Docker image should runs web application (nginx). Web application is located inside the docker image.  
  
###### Docerfile consist of below scripts
  
``FROM ubuntu``  
``RUN apt-get update``  
``RUN apt-get install nginx -y``  
``COPY html /var/www/html``  
``EXPOSE 80``  
``CMD ["nginx","-g","daemon off;"]``  

 ###### Create the new image based on the Dockerfile.  
``docker build -t mynginx_image1 .``  
 ###### Start a new container.  
``docker run --name mynginx -p 80:80 -d mynginx_image1``  
  
### 4.  Push your docker image to docker hub (https://hub.docker.com/).
  
 ``docker login``  
 ``docker tag mynginx_image1 bexruz/mynginx_image1``  
 ``docker push bexruz/mynginx_image1``  
  
### 5. Docker-compose file docker-compose.yml. Deploy a few docker containers via one docker-compose file.  
  
###### Tomcat application which uses mysql database
  
