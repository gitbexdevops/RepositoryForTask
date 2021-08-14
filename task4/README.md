### Bash script for installing Docker.  
  
The script ``install-docker.sh`` contain list of commands:  
1 - ``sudo yum update -y`` - Update the installed packages and package cache on your instance.  
2 - ``sudo yum -y install docker`` - Install the most recent Docker Engine package.  
3 - ``sudo service docker start`` -  Start the Docker service.  
4 - ``sudo usermod -a -G docker ec2-user`` - Add the ec2-user to the docker group so you can execute Docker commands without using sudo.  
5 - ``docker version`` - Check installed docker version.  
6 - ``service docker status`` - Check docker status.  
7 - ``docker pull hello-world`` - Download the image to local repository.  
8 - ``docker run hello-world`` - Run any docker container "hello world".  
