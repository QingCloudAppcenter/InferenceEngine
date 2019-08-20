host="localhost"
port="8080"
DOCKER_HOME=/usr/local/bin

prepareDir() {
  mkdir -p /data/logs && chgrp -R syslog /data/logs && chmod 775 /data/logs && cp -rf /opt/models /data/
}

init() {
  _init
  prepareDir
#  local htmlPath=/data/elasticsearch/index.html
#  [ -e $htmlPath ] || ln -s /opt/app/conf/caddy/index.html $htmlPath
}

start () {
  cd /opt/app/bin && $DOCKER_HOME/docker-compose up -d
}

stop () {
  cd /opt/app/bin && $DOCKER_HOME/docker-compose down
}

restart() {
  cd /opt/app/bin && $DOCKER_HOME/docker-compose down && $DOCKER_HOME/docker-compose up -d
}

check() {
  nc -z -w5 $host $port
}

revive() {
  restart
}

update() {
  return 0
}