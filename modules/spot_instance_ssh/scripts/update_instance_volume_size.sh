#!/bin/bash
set -ex

declare -r SPOT_INSTANCE_ID=$1
declare -r NEW_SIZE_IN_GB=$2

declare ATTACHED_VOLUME_ID

readonly ATTACHED_VOLUME_ID=$(aws ec2 describe-instances --instance-ids "$SPOT_INSTANCE_ID" \
  | jq --raw-output '.Reservations[].Instances[].BlockDeviceMappings[].Ebs.VolumeId')

aws ec2 modify-volume --volume-id "$ATTACHED_VOLUME_ID" --size "$NEW_SIZE_IN_GB"
