JAVA_HOME=/usr/java/latest
JDK_HOME=$JAVA_HOME

if ! echo ${PATH} | /bin/grep -q $JAVA_HOME/bin ; then
        PATH=$JAVA_HOME/bin:${PATH}
fi

export JAVA_HOME
export JDK_HOME
export PATH

