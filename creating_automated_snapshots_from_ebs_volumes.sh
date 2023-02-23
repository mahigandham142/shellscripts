aws ec2 describe-volumes --filters Name=tag:createdby,Values=mahesh --query "Volumes[*].{ID:VolumeId,mahesh:Tags}" | grep -i id | cut -d ':' -f 2 | tr -d "," | tr -d '"'






creating automated snapshots from ebs volumes

#!/bin/bash

for each_snapshot in $(cat volumes.txt)
do
  if which $each_snapshot &> /dev/null
  then
          echo "Already $each_snapshot is created"
  else
          echo "$each_snapshot is creating....."
           aws ec2 create-snapshot --volume-id $each_snapshot --description "This is my root volume snapshot"
          if [[ $? -eq 0 ]]
          then
                  echo "Successfully created --$each_snapshot snapshot"
          else
                  echo "unable to create --$each_snapshot"
          fi
  fi
done

