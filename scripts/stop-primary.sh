#!/bin/zsh

MYDIR="$(dirname "$(readlink -f "$0")")"

source $MYDIR/variables.zsh

# Stop the EC2 instance
aws ec2 stop-instances --region $REGION --instance-ids $INSTANCE_ID

