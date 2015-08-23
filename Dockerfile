FROM java:openjdk-7

ENV HACKPAD_HOME="/opt/hackpad"
ENV SCALA_HOME="/usr/share/scala"
ENV SCALA="$SCALA_HOME/bin/scala"
ENV SCALA_LIBRARY_JAR="$SCALA_HOME/lib/scala-library.jar"
ENV JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
ENV JAVA="/usr/bin/java"
ENV JAVA_OPTS="-Xbootclasspath/p:../infrastructure/lib/rhino-js-1.7r3.jar:$SCALA_LIBRARY_JAR"
ENV MYSQL_CONNECTOR_JAR="$HACKPAD_HOME/bin/lib/mysql-connector-java-3.1.14-bin.jar"
ENV PATH="$JAVA_HOME/bin:$SCALA_HOME/bin:$PATH"

ENV HACKPAD_ADMIN_EMAIL=hackpad@localhost
ENV HACKPAD_MYSQL_HOST=localhost
ENV HACKPAD_MYSQL_PORT=3306
ENV HACKPAD_MYSQL_DBNAME=hackpad
ENV HACKPAD_MYSQL_USER=hackpad
ENV HACKPAD_MYSQL_PASSWORD=hackpad
ENV HACKPAD_MYSQL_NEEDSSL=false

ENV HACKPAD_SMTP_SERVER=__smtp__server__
ENV HACKPAD_SMTP_USER=__smtp_user__
ENV HACKPAD_SMTP_PASSWORD=__smtp_password__

ENV HACKPAD_PORT=9000
ENV HACKPAD_TOPDOMAINS=localhost

COPY startup.sh /startup.sh

RUN cd /tmp && wget http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.deb && dpkg -i scala-2.11.7.deb && wget https://github.com/dropbox/hackpad/archive/master.zip && unzip master.zip && mv hackpad-master /opt/hackpad && chmod +x /*.sh 

COPY mysql-connector-java-3.1.14-bin.jar /opt/hackpad/bin/lib/mysql-connector-java-3.1.14-bin.jar

RUN ln -vs /opt/hackpad/bin/lib/mysql-connector-java-3.1.14-bin.jar /opt/hackpad/bin/lib/mysql-connector-java-5.1.34-bin.jar && echo "" > $HACKPAD_HOME/bin/exports.sh
# I have put all environment variables in the dockerfile, so I dont need exports.sh

EXPOSE 9000
CMD /startup.sh
