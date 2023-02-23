#To register ami

!/bin/bash
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
