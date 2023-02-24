#To deregister ami

#!/bin/bash
NOW=$( date '+%F-%H-%M-%S' )
aws ec2 describe-images --region ap-south-1  --filters "Name=tag:createdby,Values=mahesh" | grep -i "ImageId" | cut -d ":" -f 2 | tr -d '"' | tr -d ","
for each_ami in $(cat sample.txt)
do
  if which $each_ami &> /dev/null
  then
          echo "Already $each_ami is deregistered"
  else
          echo "$each_ami is deregistring....."
            aws ec2 deregister-image --image-id $each_ami
          if [[ $? -eq 0 ]]
          then
                  echo "Successfully deregistered --$each_ami ami"
          else
                  echo "unable to deregister --$each_ami"
          fi
  fi
done