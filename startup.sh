echo 'Writing setting file...'
cd /opt/hackpad/etherpad/etc
cp etherpad.localdev-default.properties etherpad.local.properties
cat <<EOF >> /opt/hackpad/etherpad/etc/etherpad.local.properties
etherpad.superUserEmailAddresses = $HACKPAD_ADMIN_EMAIL
etherpad.SQL_JDBC_URL = jdbc:mysql://$HACKPAD_MYSQL_HOST:$HACKPAD_MYSQL_PORT/$HACKPAD_MYSQL_DBNAME
etherpad.SQL_PASSWORD = $HACKPAD_MYSQL_PASSWORD
etherpad.SQL_USERNAME = $HACKPAD_MYSQL_USER
listen = $HACKPAD_PORT
topdomains = $HACKPAD_TOPDOMAINS,localhost
smtpServer = $HACKPAD_SMTP_SERVER
smtpUser = $HACKPAD_SMTP_USER
smtpPass = $HACKPAD_SMTP_PASSWORD
etherpad.SQL_REQUIRE_SSL = $HACKPAD_MYSQL_NEEDSSL
EOF

echo 'Start to build hackpad...'
cd /opt/hackpad/bin
./build.sh
./run.sh
