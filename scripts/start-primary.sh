#!/bin/zsh

MYDIR="$(dirname "$(readlink -f "$0")")"

source $MYDIR/variables.zsh


# Start the EC2 instance
aws ec2 start-instances --region $REGION --instance-ids $INSTANCE_ID
