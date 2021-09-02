### Install ELK
##### Install Elasticsearch
`curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -`  
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list`  
`sudo apt update`  
`sudo apt install elasticsearch`  
###### File to edit config file:  
`sudo nano /etc/elasticsearch/elasticsearch.yml`  
###### Restart needed after config file changes
`sudo systemctl start elasticsearch`  
`sudo systemctl enable elasticsearch` 
###### Check if Elasticsearch runnig
`curl -X GET "localhost:9200"`  
##### Installing and Configuring the Kibana Dashboard
`sudo apt install kibana`  
`sudo systemctl enable kibana`  
`sudo systemctl start kibana`  
##### Installing and Configuring Logstash
`sudo apt install logstash`  
##### Logstash’s configuration files reside in the /etc/logstash/conf.d directory  
##### Test your Logstash configuration with this command:  
`sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t`  
`sudo systemctl start logstash`  
`sudo systemctl enable logstash`  
##### Installing and Configuring Filebeat  
`sudo apt install filebeat`  
##### Edit config file
`sudo nano /etc/filebeat/filebeat.yml`  
##### Enable requird modules  
`sudo filebeat modules enable system`  
`sudo filebeat setup --pipelines --modules system`  
##### To load the template, use the following command:
`sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'`  
##### disable the Logstash output and enable Elasticsearch output:
`sudo filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['localhost:9200'] -E setup.kibana.host=localhost:5601` 
`sudo systemctl start filebeat`  
`sudo systemctl enable filebeat`  
##### To verify that Elasticsearch is indeed receiving this data, query the Filebeat index with this command:  
`curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty'`  
### Open http://192.168.1.14:5601/ and check dashboard





