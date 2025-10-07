#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=2  # in project we keep it as 75%

while IFS= read -r line
do
  USAGE=$(echo "$line" | awk '{print $6}' | cut -d "%" -f1)
  MOUNT_POINT=$(echo "$line" | awk '{print $7}')

  if [ "$USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "High disk usage detected on $MOUNT_POINT: ${USAGE}%"
  else
    echo "Disk usage on $MOUNT_POINT is normal: ${USAGE}%"
  fi
done <<< "$DISK_USAGE"
