aws ec2 describe-instances | grep -i "instanceid" | cut -d ":" -f 2 | tr -d '"' | tr -d ","

 aws ec2 describe-images --region ap-south-1  --filters "Name=tag:createdby,Values=mahesh" | grep -i "ImageId" | cut -d ":" -f 2 | tr -d '"' | tr -d ","

 aws ec2 create-image --instance-id $each_ami --name $each_ami --description "An AMI for my server" --tag-specifications ResourceType=image,Tags="[{Key=createdby,Value=mahesh}]"




#!/bin/bash

for each_ami in $(cat demo.txt)
do
  if which $each_ami &> /dev/null
  then
          echo "Already $each_ami is installed"
  else
          echo "$each_ami is creating....."
           aws ec2 create-image --instance-id $each_ami --name $each_ami --description "An AMI for my server" --tag-specifications ResourceType=image,Tags="[{Key=createdby,Value=mahesh}]
          if [[ $? -eq 0 ]]
          then
                  echo "Successfully created --$each_ami ami"
          else
                  echo "unable to create --$each_ami"
          fi
  fi
done

To register ami

#!/bin/bash
aws ec2 describe-instances | grep -i "instanceid" | cut -d ":" -f 2 | tr -d '"' | tr -d "," >> demo.txt
for each_ami in $(cat demo.txt)
do
  if which $each_ami &> /dev/null
  then
          echo "Already $each_ami is created"
  else
          echo "$each_ami is creating....."
           aws ec2 create-image --instance-id $each_ami --name $each_ami --description "An AMI for my server" --tag-specifications ResourceType=image,Tags="[{Key=createdby,Value=mahesh}]"
          if [[ $? -eq 0 ]]
          then
                  echo "Successfully created --$each_ami ami"
          else
                  echo "unable to create --$each_ami"
          fi
  fi
done






To deregister ami

#!/bin/bash
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
