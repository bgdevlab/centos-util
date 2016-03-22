#!/usr/bin/env bash

ident=`basename "$0"`
logfile="`pwd`/log.$ident"
errlogfile=$logfile
touch $logfile

osversion=5
script_baseurl="https://raw.githubusercontent.com/bgdevlab/centos-util/os/${osversion}"

lognow(){
    #ident="install.amq"
    local tstamp=`date +%F\ %H:%M:%S`
    local message="$1"
    echo "$tstamp,$ident,$message" | tee -a $logfile
}

installActiveMQ510() {
    amqv=5.10
    /usr/sbin/useradd activemq
    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq

    # Requires JAVA6 to be installed.
    # ACTIVEMQ
    lognow "install activemq-$amqv application"

    dist_activemq="http://apache.uberglobalmirror.com/activemq/5.10.2/apache-activemq-5.10.2-bin.tar.gz"
    init_activemq="${script_baseurl}/scripts/apache/activemq/apache-activemq-5.10.2-bin.init"

    dist_archive=`basename "$dist_activemq"`
    init_script=`basename "$init_activemq"`

    lognow "checking for local $dist_archive file (this may have been copied here by PACKER)"
    if [ ! -f $dist_archive ]; then
        wget --no-check-certificate $dist_activemq 2>&1
    else
        lognow "found local archive $dist_archive"
    fi

    lognow "checking for local $init_script file (this may have been copied here by PACKER)"
    if [ ! -f $init_script ]; then
        wget --no-check-certificate $init_activemq 2>&1
    else
        lognow "found local archive $init_script"
    fi

    lognow "extracting activemq "
    tar -xf "$dist_archive" -C /home/activemq/ 2>>$errlogfile

    cp -f "$init_script" /etc/init.d/activemq
    chmod 755 /etc/init.d/activemq
    #/sbin/chkconfig activemq on -- chkconfig not supported  (actually can be fixed with approparite/compliant headers in activemq init.d file)

    lognow "generate activemq config"
    /etc/init.d/activemq setup /etc/default/activemq

    /sbin/service activemq restart

    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq

    /sbin/chkconfig --add activemq
    /sbin/chkconfig activemq on
}



installActiveMQ58() {
    amqv=5.8
    /usr/sbin/useradd activemq
    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq

    # Requires JAVA6 to be installed.
    # ACTIVEMQ
    lognow "install activemq-$amqv application"

    dist_activemq="http://archive.apache.org/dist/activemq/apache-activemq/5.8.0/apache-activemq-5.8.0-bin.tar.gz"
    init_activemq="${script_baseurl}/scripts/apache/activemq/apache-activemq-5.8.0-bin.init"

    dist_archive=`basename "$dist_activemq"`
    init_script=`basename "$init_activemq"`

    lognow "checking for local $dist_archive file (this may have been copied here by PACKER)"
    if [ ! -f $dist_archive ]; then
        wget --no-check-certificate $dist_activemq 2>&1
    else
        lognow "found local archive $dist_archive"
    fi

    lognow "checking for local $init_script file (this may have been copied here by PACKER)"
    if [ ! -f $init_script ]; then
        wget --no-check-certificate $init_activemq 2>&1
    else
        lognow "found local archive $init_script"
    fi

    lognow "extracting activemq "
    tar -xf "$dist_archive" -C /home/activemq/ 2>>$errlogfile

    cp -f "$init_script" /etc/init.d/activemq58
    chmod 755 /etc/init.d/activemq58
    #/sbin/chkconfig activemq on -- chkconfig not supported

    lognow "generate activemq config"
    /etc/init.d/activemq58 setup /etc/default/activemq

    #/sbin/service activemq restart

    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq
    
    /sbin/chkconfig --add activemq58
    /sbin/chkconfig activemq58 off

}

installActiveMQ52() {
    amqv=5.2
    /usr/sbin/useradd activemq
    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq
    
    # Requires JAVA6 to be installed.
    # ACTIVEMQ

    lognow "install activemq-$amq application"


    dist_activemq="http://archive.apache.org/dist/activemq/apache-activemq/5.2.0/apache-activemq-5.2.0-bin.tar.gz"
    init_activemq="${script_baseurl}/scripts/apache/activemq/apache-activemq-5.2.0.init"
    
    dist_archive=`basename "$dist_activemq"`
    init_script=`basename "$init_activemq"`

    lognow "checking for local $dist_archive file (this may have been copied here by PACKER)"
    if [ ! -f $dist_archive ]; then
        wget --no-check-certificate $dist_activemq 2>&1
    else
        lognow "found local archive $dist_archive"        
    fi

    lognow "checking for local $init_script file (this may have been copied here by PACKER)"
    if [ ! -f $init_script ]; then
        wget --no-check-certificate $init_activemq 2>&1
    else
        lognow "found local archive $init_script"
    fi
    
    tar -xf "$dist_archive" -C /home/activemq/ 2>>$errlogfile
    
    # http://stackoverflow.com/questions/6739258/how-do-i-add-a-line-of-text-to-the-middle-of-a-file-using-bash
    activemq_start=/home/activemq/`basename "$dist_activemq" -bin.tar.gz`/bin/activemq
    lognow "install activemq service script"

    if [ -f "$init_script" ]; then
        # http://stackoverflow.com/questions/6284518/how-to-insert-a-line-using-sed-before-a-pattern-and-after-a-line-number
        cp "$activemq_start" "$activemq_start".original
        # Add code at line position 17 - just after comments
        lognow "tweaking '$activemq_start' to allow PID"
        sed -e '17a\if [ "$ACTIVEMQ_PID" ];  then echo $$ > "$ACTIVEMQ_PID"; fi' $activemq_start > "$activemq_start".new
        lognow "created $activemq_start.new"
        mv -f "$activemq_start".new "$activemq_start"
        cp -f "$init_script" /etc/init.d/activemq
        chmod 755 /etc/init.d/activemq
        /sbin/chkconfig activemq on

    else
        lognow "ERROR: cannot install activemq service"
    fi
    chown -R activemq:activemq /home/activemq
    chmod -R 755 /home/activemq
}


usage() {
    cat << USAGE 
This script can install different AMQ.
The script relies on 2 environment variables, AMQ_ACTION  and AMQ_VERSION, they both MUST be set for the script to work.
  AMQ_VERSION - [ amq52 | amq58 | amq510]
  AMQ_ACTION  - [ info | install | clean ]
  
Command line argument override these environment variables, the order in ACTION VERSION  
USAGE
}

cleanup() {
    lognow "cleaning: removing activemq binaries"
    rm -f apache-activemq-*
}


serviceAction=usage
serviceVersion=

# Environment variables are required for Packer builds.
if [ -n "$AMQ_ACTION" ]; then
    serviceAction=$AMQ_ACTION
fi

if [ -n "$AMQ_VERSION" ]; then
    serviceVersion=$AMQ_VERSION
fi

lognow "Command line arguments override Environment variables."
if [ $2 ]; then
    serviceAction=$1
    serviceVersion=$2     
fi

STATUS=$( cat <<MESSAGE
Using
    AMQ_ACTION  = [$serviceAction]
    AMQ_VERSION = [$serviceVersion]
MESSAGE
)

lognow "$STATUS"
if [ "$serviceAction" == "info" ]; then

    lognow "show activemq versions `ls /home/activemq/ | sed 's/apache-activemq-//'`"
    exit 0

elif [ "$serviceVersion" == "amq510" ] && [ "$serviceAction" == "install" ]; then

    lognow "install activemq 5.10"
    installActiveMQ510

elif [ "$serviceVersion" == "amq58" ] && [ "$serviceAction" == "install" ]; then

    lognow "install activemq 5.8"
    installActiveMQ58

elif [ "$serviceVersion" == "amq52" ] && [ "$serviceAction" == "install" ]; then

    lognow "install activemq 5.2"
    installActiveMQ52

elif [ "$serviceAction" == "clean" ]; then

    cleanup

else
    lognow "action is - show usage()"
    usage        
fi
