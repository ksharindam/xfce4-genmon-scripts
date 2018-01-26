#!/bin/sh
vcgencmd measure_temp | cut -d '=' -f 2
