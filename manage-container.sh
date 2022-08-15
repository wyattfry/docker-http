#!/usr/bin/env bash
set -xe 


DOCKER_USER=moreworld

function is_running() {
    container="$1"
	[[ $(docker container ls -aq --filter name="$container" | wc -l) -gt 0 ]]
}


function start_container() {
    image=${1}
    port=${2}
	echo "Starting container $image port $port"
	docker pull "${DOCKER_USER}/${image}"
    if is_running "$image"; then
		echo "Container $image started. Restarting container..."
		stop_container "$image"
	fi
	docker run --name "$image" --restart always --detach -p="0.0.0.0:$port:8080" "$DOCKER_USER/$image"
}


function stop_container() {
    local container="$1"
	if is_running "$container"; then
	    echo "Stopping container '$container'"
		docker stop "$container"
	else
		echo "Container $container already stopped"
	fi
    echo "Removing container $container"
	docker rm "$container" || echo "could not remove container. it may not have existed."
}

function restart_container() {
    image=${1}
    port=${2}
	stop_container "$image" 
	start_container	"$image" "$port" 
}

verb="$1"
image="$2"
port="$3"

# 8080  filebin        ferryhandy.com
# 8081  wyattfry-com   wyattfry.com
# 8082  canvas-game    canvas-game.wyattfry.com

# e.g. manage_container.sh restart filebin 8080

case $verb in
	start) start_container ;;
	stop)  stop_container  ;;
	restart) restart_container "$image" "$port" ;;
	*) echo Must include a verb, start stop or restart && exit 1
esac
