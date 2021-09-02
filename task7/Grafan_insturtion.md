### install the latest OSS release:
`sudo apt-get install -y apt-transport-https`  
`sudo apt-get install -y software-properties-common wget`  
`wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -`  
`echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list`  
`echo "deb https://packages.grafana.com/oss/deb beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list`  
`sudo apt-get update`  
`sudo apt-get install grafana`  
##### Start the server  
`sudo systemctl daemon-reload`  
`sudo systemctl start grafana-server`  
`sudo systemctl status grafana-server`  
`sudo systemctl enable grafana-server.service`  
##### Open grafana http://192.168.1.14:3000/  
##### Settings:  
Name: Elasticsearch  
URL:  http://127.0.0.1:9200  
Access: Default server  
Index name: logstash-2015.05.18  
Version: 7.10+  
Save and Test  
Add Dashboard  
Choose time  

