#!/bin/bash
set -x

echo "Get instance id ..."
instance_id=`curl http://169.254.169.254/latest/meta-data/instance-id` 