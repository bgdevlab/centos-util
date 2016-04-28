# centos-util
CentOS utlity and build scripts, OS version 5.

| Release     | Branch    | CentOS Version  |
| ----------- | --------- | --------------- |
| 1.0         | os/5      | CentOS 5.x      |
| 2.0         | master    | CentOS 6.x      |

## Packages

 - apache/activemq
 - apache/tomcat
 
## ActiveMQ

 To install __apache-activemq 5.10__ and tidy up post install. 
 
    time curl --silent --show-error -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.activemq.sh && chmod +x install.activemq.sh
    time ./install.activemq.sh install amq510
    time ./install.activemq.sh clean amq510

 To install __apache-activemq 5.8__ and tidy up post install. 
 
    time curl --silent --show-error -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.activemq.sh && chmod +x install.activemq.sh
    time ./install.activemq.sh install amq58
    time ./install.activemq.sh clean amq58
 
 Note other options exist
 
## Tomcat

 To install __apache-tomcat 6.0.18__.
  
    time curl --silent --show-error  -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.tomcat.sh && chmod +x install.tomcat.sh
    time ./install.tomcat.sh

## Oracle JDK

 To install __Oracle JDK 1.6.u45__.

    time curl --silent --show-error  -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.jdk6.sh && chmod +x install.jdk6.sh
    time ./install.jdk6.sh


To install __Oracle JDK 1.8.u73__.

    time curl --silent --show-error  -O https://raw.githubusercontent.com/bgdevlab/centos-util/os/5/scripts/install.jdk8.sh && chmod +x install.jdk8.sh
    time ./install.jdk8.sh
