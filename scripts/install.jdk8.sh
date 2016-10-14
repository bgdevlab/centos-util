#!/usr/bin/env bash
# see https://gist.github.com/theodson/ed84e9c80c97ca8af53a

time curl https://raw.githubusercontent.com/bgdevlab/centos-util/master/scripts/oracle/getOracleJDK.sh | bash -s "rpm" "8" 2>/dev/null \
    && yum -y localinstall --nogpgcheck jdk-8u*-linux-x64*.rpm* \
    && rm -f jdk-8u*-linux-x64*.rpm*

