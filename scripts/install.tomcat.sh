#!/usr/bin/env bash

ident=`basename "$0"`
logfile="`pwd`/log.$ident"
errlogfile=$logfile
touch $logfile

osversion=5
script_baseurl="https://raw.githubusercontent.com/bgdevlab/centos-util/os/${osversion}"

lognow(){
    #ident="install.tomcat"
    local tstamp=`date +%F\ %H:%M:%S`
    local message="$1"
    echo "$tstamp,$ident,$message" | tee -a $logfile
}


installTomcat() {

    # service users
    /usr/sbin/useradd tomcat
    chown -R tomcat:tomcat /home/tomcat
    chmod -R 755 /home/tomcat

    /etc/init.d/tomcat stop 2>/dev/null

    dist_tomcat="https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.18/bin/apache-tomcat-6.0.18.tar.gz"
    init_tomcat="${script_baseurl}/scripts/apache/tomcat/apache-tomcat-6.0.18.init"

    dist_archive=`basename "$dist_tomcat"`
    init_script=`basename "$init_tomcat"`

    lognow "checking for local $dist_archive file"
    if [ ! -f $dist_archive ]; then
        curl --silent --show-error -O $dist_tomcat 2>&1
    else
        lognow "found local archive $dist_archive"
    fi

    lognow "checking for local $init_script file"
    if [ ! -f $init_script ]; then
        curl --silent --show-error -O $init_tomcat 2>&1
    else
        lognow "found local archive $init_script"
    fi
    
    # TOMCAT
    lognow "install tomcat application"
    tar -xf "$dist_archive" -C /home/tomcat/ 2>>$errlogfile
    chown -R tomcat:tomcat /home/tomcat

    {
        # install tomcat as a service.
        pushd /home/tomcat/apache-tomcat-6.0.18/bin/
        tar -xf jsvc.tar.gz

        pushd /home/tomcat/apache-tomcat-6.0.18/bin/jsvc-src/
        # read /home/tomcat/apache-tomcat-6.0.18/bin/jsvc-src/INSTALL.txt
        export JAVA_HOME=/usr/java/default
        chmod +x ./configure
        ./configure
        make
        cp jsvc ..
        chown -R tomcat:tomcat /home/tomcat
        popd;popd;
    }

    lognow "install tomcat service script"
    if [ -f "$init_script" ]; then
        chmod 755 "$init_script"
        cp -f "$init_script" /etc/init.d/tomcat
        /sbin/chkconfig tomcat on
    else
        lognow "ERROR: cannot install tomcat service"
    fi

}

cleanup() {
    rm -f apache-tomcat-*
}

installTomcat
cleanup

