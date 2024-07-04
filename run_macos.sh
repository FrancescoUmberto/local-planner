./build.sh

# docker run -it --rm \
# 	--name local-planner --net host --privileged --ipc host \
# 	-e DISPLAY=docker.for.mac.host.internal:0 \
# 	-v /tmp/.X11-unix:/tmp/.X11-unix \
# 	-v $(pwd):/home/local-planner  \
# 	-w /home/local-planner \
# 	polibax/localplanner:base bash 

    
#!/bin/bash

# Find the container ID of the running ros-test-path_planning image
container_id=$(docker ps -qf "ancestor=local-planner")

# Check if the container ID was found
if [ -z "$container_id" ]; then
    # No containers running

    # Get the IP address of the en0 interface
    ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

    # Allow access to the X server from the Docker container
    xhost + $ip

    # Run the Docker container with specific settings
  echo "Running the container..."
#    docker run -it --rm --net host --ipc host -e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix:rw ros-test-path_planning
    docker run -it --rm \
	--name local-planner --net host --privileged --ipc host \
	-e DISPLAY=$ip:0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $(pwd):/home/local-planner  \
	-w /home/local-planner \
	polibax/localplanner:base bash 
    exit 1
fi

# Execute /bin/bash inside the container
echo "Container ID: $container_id"
docker exec -it $container_id /bin/bash -c "source /opt/ros/humble/setup.bash && /bin/bash"
# -e DISPLAY=$DISPLAY \ everywhere except for Mac