# centos-util
CentOS utlity and build scripts, OS version 5.


## Packages

 - apache/activemq
 - apache/tomcat
 
## ActiveMQ

 To install __apache-activemq 5.10__ and tidy up post install. 
 
    time curl --silent --show-error -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.activemq.sh && chmod +x install.activemq.sh && ./install.activemq.sh install amq510
    ./install.activemq.sh clean amq510

 To install __apache-activemq 5.8__ and tidy up post install. 
 
    time curl --silent --show-error -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.activemq.sh && chmod +x install.activemq.sh && ./install.activemq.sh install amq510
    ./install.activemq.sh clean amq58
 
 Note other options exist
 
## Tomcat

 To install __apache-tomcat 6.0.18__.
  
    time curl --silent --show-error  -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.tomcat.sh && chmod +x install.tomcat.sh && ./install.tomcat.sh
