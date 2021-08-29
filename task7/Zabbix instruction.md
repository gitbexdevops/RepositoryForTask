##### Install and configure Zabbix server for your platform  
`# wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb`  
`# dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb`  
`# apt update` 
##### Install Zabbix server, frontend, agent  
`# apt install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent`  
##### Install MySQL
`sudo apt-get update`  
`sudo apt-get install mysql-server`  
##### Create initial database  
`# mysql -uroot -p`  
`password`  
`mysql> create database zabbix character set utf8 collate utf8_bin;`  
`mysql> create user zabbix@localhost identified by 'password';`  
`mysql> grant all privileges on zabbix.* to zabbix@localhost;`  
`mysql> quit;`  
##### On Zabbix server host import initial schema and data. Will be prompted to enter newly created password.
`# zcat /usr/share/doc/zabbix-sql-scripts/mysql/create.sql.gz | mysql -uzabbix -p zabbix`  
##### Configure the database for Zabbix server  
Edit file /etc/zabbix/zabbix_server.conf  
`DBPassword=password`  
##### Configure PHP for Zabbix frontend  
Edit file /etc/zabbix/nginx.conf, uncomment and set 'listen' and 'server_name' directives. 
`# listen 80;`  
`# server_name example.com;`  
##### Start Zabbix server and agent processes  
` # systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm`  
` # systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm`  
##### Connect to newly installed Zabbix frontend: http://18.222.215.7:8080/
##### Temporarily chmod 777 access need to be granted to download directory folder
##### Adding host  
*Configuration → Hosts → Create host.*  
**Host name** = New-Test-Host  
**Groups**  = Linux servers, Virtual machines  
**IP address** = 18.117.223.167  
##### Adding item  
*Configuration → Hosts and find the "New host" → Items → "New host" → click on Create item.*  
**Name** =  CPU load  
**Key** =  system.cpu.load  
##### On other VM install Zabbix Agent
`sudo yum install zabbix-agent -y`  
##### Open config file  
`sudo vim /etc/zabbix/zabbix_agentd.conf`  
##### Change the following lines:  
`Server=18.222.215.7` Zabbix_server_ip  
`ServerActive=18.222.215.7:10050`  
`Hostname=18.117.223.167` hostaname_of_agent_server  
##### After start zabbix agent check connections 
` nc -v -z 18.117.223.167 10050`  
`Connection to 18.117.223.167 10050 port [tcp/zabbix-agent] succeeded!`  
`ubuntu@ip-10-0-0-146:~$ nc -v -z 18.222.215.7 10051`  
`Connection to 18.222.215.7 10051 port [tcp/zabbix-trapper] succeeded!`  

