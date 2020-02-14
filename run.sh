#!/bin/bash
docker run -i -t -e XAUTHORITY=/tmp/xauth -v ~/.Xauthority:/tmp/xauth -v /tmp/.X11-unix/:/tmp/ -v /var/tmp:/var/tmp -e DISPLAY=$DISPLAY --net=host gnuradiodocker