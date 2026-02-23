# ros_noetic_docker

This provides a minimal Docker environment for running ROS Noetic.

# Usage

Put this repository inside the top-level directory of your ROS workspace folder. The workspace folder should be named (`fast_calib_ws`). First build the container, then start it. Once the container is started, you can open up any # of terminals using `./noetic_attach`.

To stop the container, run `./noetic_kill`.

# Commands

## Building

`./noetic_build.sh`

## Starting the Container

The `noetic_start.sh` script starts the Docker container and takes as input a list of yml files with Docker compose configurations to include:

`./noetic_start.sh <list of yml files separated by spaces>`

### Default

`./noetic_start.sh`

### Additional Volumes

If you want additional volumes to be mounted, create an additional yml file `additional-mounts.yml` in this directory with the following structure:

```
services:
    ros-noetic:
        volumes:
            <list of volumes>
```

See the volumes section of `docker-compose.yml` for an example of how the volumes section should look.

Then to include this file when starting the container:

`./noetic_start.sh additional-mounts.yml`

### Including GPU

`./noetic_start.sh nvidia-runtime.yml`

## Attaching to the Container

To run commands inside the Docker container (such as `catkin build` or any ROS commands):

`./noetic_attach.sh`

**NOTE**: will need to run `source /opt/ros/noetic/setup.bash` in each terminal

## Stopping the Container

`./noetic_kill.sh`