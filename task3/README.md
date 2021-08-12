
This is Task3 createing AWS EC2 instances (Ubuntu and CentOS)

EC2 Ubuntu have Internet access, there incoming access: ICMP, TCP/22, 80, 443, and any outgoing access.
EC2 CentOS have access to the Internet, but have outgoing and incoming access: ICMP, TCP/22, 80, 443 only on the local network where EC2 Ubuntu, EC2 CentOS is located.
On EC2 Ubuntu, install a web server (nginx/apache);
a web page with the text “Hello World” and information about the current version of the operating system. This page visible from the Internet.

On EC2 Ubuntu installed Docker
