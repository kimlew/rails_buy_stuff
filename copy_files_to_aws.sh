#! /usr/bin/env bash

# SCRIPT NAME: copy_files_to_aws.sh

# DESCRIPTION: This script is called in main.sh to transfer files needed on the
# the deployment machine on AWS at its root directory for correct set up of 
# the Buy Stuff web app.

# Note: Web app files & folders are part of Docker image.

# AUTHOR: Kim Lew

set -e

# The IP address and the .pem key are passed in from main.sh. 
# AWS & SSH require the .pem key.
PEM_KEY=$1
IP_ADDR=$2

echo "COPYING files from local machine to AWS..."
echo

SRC_DIR_LOCAL='/Users/kimlew/code/ruby3_rails7_mysql_buy_stuff/rails_buy_stuff/' # On Mac.
DEST_ON_AWS='/home/ubuntu/' # Path to root directory on deployment machine/AWS.
# Note: /home/ubuntu/ - is root on AWS EC2 instance with Ubuntu 22.04.

# Copy setup_machine.sh & docker-compose.yml to root directory on AWS EC2 instance.
scp -i "${PEM_KEY}" "${SRC_DIR_LOCAL}"setup_machine.sh ubuntu@"${IP_ADDR}":"${DEST_ON_AWS}"setup_machine.sh
scp -i "${PEM_KEY}" "${SRC_DIR_LOCAL}"compose.yaml ubuntu@"${IP_ADDR}":"${DEST_ON_AWS}"compose.yaml
