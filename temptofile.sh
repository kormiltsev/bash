#!/bin/bash

while true; do cat /sys/class/thermal/thermal_zone0/temp; echo -n "$(date +%Y-%m-%d,%H:%M:%S,)" >> temps ; echo $(cat /sys/class/thermal/thermal_zone0/temp | cut -c -4) >> temps; sleep 60; done
