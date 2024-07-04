./build.sh

docker run -it --rm \
	--name local-planner --net host --privileged --ipc host \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $(pwd):/home/local-planner  \
	-w /home/local-planner \
	polibax/localplanner:base bash 

    
