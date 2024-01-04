#!/bin/bash
[[ $(ps aux | grep '[X]vfb\|[w]ebsockify 8080\|[x]11vnc -localhost' | wc -l) -ge '3' ]]
exit $?
