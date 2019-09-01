host="localhost"
port="9000"
DOCKER_HOME=/usr/local/bin

prepareDir() {
  mkdir -p /data/minio/{logs,data} && chgrp -R syslog /data/minio/logs && chmod -R 775 /data && mkdir -p /data/models_to_load && chmod -R +rx /opt/models && cp -rf /opt/models /data/minio/data/
}

init() {
  _init
  prepareDir
  local htmlPath=/data/index.html
  [ -e $htmlPath ] || ln -s /opt/app/conf/caddy/index.html $htmlPath
}

start () {
  _start && cd /opt/app/bin && $DOCKER_HOME/docker-compose up -d
}

stop () {
  cd /opt/app/bin && $DOCKER_HOME/docker-compose down && _stop
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

_restart_envoy() {
  docker stop envoy && cd /opt/app/bin && $DOCKER_HOME/docker-compose up -d
}

scale_in() {
  _restart_envoy 
}

scale_out() {
  _restart_envoy 
}

update() {
  return 0
}