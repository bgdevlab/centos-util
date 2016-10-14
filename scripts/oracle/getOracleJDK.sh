# http://stackoverflow.com/questions/10268583/downloading-java-jdk-on-linux-via-wget-is-shown-license-page-instead

# default is JDK 8
rpmfile="http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm"
archfile="http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz"

if [ "$2" == '6' ]; then
        rpmfile="http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin"
        archfile="http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
fi

if [ "$2" == '7' ]; then
        rpmfile="http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm"
        archfile="http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz"
fi

if [ "$1" == 'rpm' ]; then
        getfile=$rpmfile
else
        getfile=$archfile
fi

filename="$(echo $getfile | rev | cut -d "/" -f -1 | rev)"
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "$getfile" -O $filename