#!/bin/bash

check_partitions () {
  while read -r line; do
    echo $line | sed 's/\%//g' | awk 'END {
      mount_point = $NF
      disk_usage = $6
      if (disk_usage > 30)
        print "usage above 30% for mount point " mount_point
    }'
  done <<< "$(df -hT | grep -v '/dev/loop' | sed '1d')"
}

check_partitions
