DOCKER_IMAGE="riscv-softfloat:latest"
DOCKER_UID="$(id -u)"
DOCKER_GID="$(id -g)"
DOCKER_PWD="$PWD"
DOCKER_CMD="make -C $DOCKER_PWD tao"

#echo "Run command without gosu"
#docker run -it --rm				\
#	--user=$DOCKER_UID:$DOCKER_GID		\
#	--volume="$DOCKER_PWD:$DOCKER_PWD"	\
#	$DOCKER_IMAGE				\
#	$DOCKER_CMD

echo "Run command with gosu"
docker run -it --rm				\
	--volume="$DOCKER_PWD:$DOCKER_PWD"	\
	$DOCKER_IMAGE				\
	gosu $DOCKER_UID:$DOCKER_GID		\
	$DOCKER_CMD
