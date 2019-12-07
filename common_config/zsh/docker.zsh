###############################################################
# Docker Helpers
# @author https://github.com/jmervine
###############################################################

# Docker
# alias dockerps='docker ps --format=$FORMAT'
# alias dockerconc='docker ps -aq --no-trunc | xargs docker rm'
# alias dockerLamp='docker run -v /work/Docker:/var/www/example.com/public_html -p 80:80 -t -i linode/lamp /bin/bash'
# alias dklc='docker ps -l'  # List last Docker container
# alias dklcid='docker ps -l -q'  # List last Docker container ID
# alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
# alias dkps='docker ps'  # List running Docker containers
# alias dkpsa='docker ps -a'  # List all Docker containers
# alias dki='docker images'  # List Docker images
# alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
# alias dkrmlc='docker-remove-most-recent-container'  # Delete most recent (i.e., last) Docker container
# alias dkrmui='docker images -q -f dangling=true |xargs -r docker rmi'  # Delete all untagged Docker images
# alias dkrmall='docker-remove-stale-assets'  # Delete all untagged images and exited containers
# alias dkrmli='docker-remove-most-recent-image'  # Delete most recent (i.e., last) Docker image
# alias dkrmi='docker-remove-images'  # Delete images for supplied IDs or all if no IDs are passed as arguments
# alias dkideps='docker-image-dependencies'  # Output a graph of image dependencies using Graphiz
# alias dkre='docker-runtime-environment'  # List environmental variables of the supplied image ID
# alias dkelc='docker exec -it `dklcid` bash' # Enter last container (works with Docker 1.3 and above)

function docker_clean {
  echo "+ clean containers"
  docker ps -a | grep -v 'NAMES' | grep -v 'Up ' | awk '{ print $NF }' | xargs docker rm

  echo "+ clean images"
  docker images | grep '^<none>' | awk '{ print $3 }' | xargs docker rmi
}

function docker_killall {
  echo "+ killing all containers"
  docker ps | awk '{print $NF}' | grep -v 'NAMES' | xargs docker kill
}

function docker_stopall {
  echo "+ stopping all containers"
  docker ps | awk '{print $NF}' | grep -v 'NAMES' | xargs docker stop
}

docker_exec="$(which docker)"

function docker {
  case "$@" in
  clean)
    docker_clean
    return 0;;
  stopall)
    docker_stopall
    return $?;;
  killall)
    docker_killall
    return $?;;
  esac
  $docker_exec $@
}

## Noop Server - Clean http listener
function listen {
  local port="$1"
  local addr="$2"

  [[ -z $port ]] && port=3000
  [[ -z $addr ]] && addr=0.0.0.0

  x docker run --rm -it -p "$port:$port" -e PORT=$port -e ADDR=$addr jmervine/noop-server
}

## Run Server to serve files from a local directory
function serve {
  local port="$1"
  [[ -z $port ]] && port=3000

  x docker run -it --rm -p ${port}:80 -v $(pwd):/usr/share/nginx/html nginx:alpine
}

## fix up docker generated files
function own {
  local _path="$1"
  [[ -z $_path ]] && _path="."

  find $_path -user root | xargs sudo chown jmervine:
}

function dcex {
  local cmd="bash"
  test "$1" && cmd=$1
  echo "+ docker exec -it $(docker ps | grep $(basename $(pwd))_web | awk '{ print $(NF) }') $cmd"
  docker exec -it "$(docker ps | grep "$(basename "$(pwd)")"_web | awk '{ print $(NF) }')" "$cmd"
}

function rr {
  local v=$1
  [[ -z $v ]] && v=latest

  docker run -it --rm -v "$(pwd)":/src jmervine/herokudev-ruby:$v
}
