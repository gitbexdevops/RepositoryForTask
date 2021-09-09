### Task8 instruction CI/CD  

##### Have two instances  
1 - Jenkins server : VirtualBox Ubuntu 20.04 machine  
2 - Application server : AWS EC2 Ubuntu 20.04 machine  

##### Clone application repository to Application server  
`git clone https://github.com/gitbexdevops/RepositoryForTask-task8.git`
##### change directory to dowloaded folder   
`cd RepositoryForTask-task8.git`  
##### run commands to deploy containers  
`bin/setup`  
`docker network create reaction.localhost`  
`docker-compose up -d`  
