#!/bin/bash
set -x

echo "retrieve instance ID and retag Instance"
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
sleep 10
aws ec2 create-tags --resources $INSTANCE --tags Key=Name,Value=${CURRENT_TAG}-$INSTANCE_ID --region ${region}