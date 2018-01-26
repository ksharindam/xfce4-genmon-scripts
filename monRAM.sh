#!/bin/bash

mem_list=($(free | grep 'Mem'))
total=${mem_list[1]}
free=${mem_list[3]}
let "used=($total-$free)/1024"
echo ${used}M
