#! /usr/bin/env bash

# SCRIPT NAME: main.sh

# DESCRIPTION: This script runs scripts required to copy files to the
# deployment machine, i.e., AWS, sets up the deployment machine that has a  
# Docker container and launches the Buy Stuff app using Docker Compose.

# AUTHOR: Kim Lew

# Note: To see meanings of set flags, type: help set
# set -e  Exits immediately if a command exits with a non-zero status.
# set -x  Prints commands and their arguments as they are executed.
set -e

# Prompt user for PEM_KEY and IP_ADDR. Then read in the variables.
read -resp "Type the full path to the .pem key: " PEM_KEY
echo
read -rep "Type the IP address: " IP_ADDR
echo
echo "SETTING UP See Stuff..."
echo

# These lines run on your local computer, e.g., Mac.
chmod u+x copy_files_to_aws.sh
./copy_files_to_aws.sh "${PEM_KEY}" "${IP_ADDR}"

# These commands run in a shell on Deployment Machine, e.g., AWS EC2 instance.
# TEST ssh with, e.g., ssh -i <full path>/key.pem ec2-user@34.213.67.66
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- chmod u+x setup_machine.sh \&\& \
  ./setup_machine.sh

# CHECK 1: Manually ssh & ls to verify files were copied to AWS.
# CHECK 2: Run these verification lines but UNCOMMENT later: 
echo "Current directory & files copied over are:"
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- pwd
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- ls -laht
echo
echo "Docker & Docker Compose versions installed are:"
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- docker -v
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- docker compose version
echo

# Add docker group & user to docker group.
# -v, --invert-match. Selected lines are those not matching any of the  
# specified patterns. -q , --quiet, --silent. Quiet mode: suppress normal output
echo "ADD if no docker group on EC2 instance. ADD also your user to group."
echo
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- /bin/sh <<'EOF'
  echo "The groups are: "
  groups
  echo
  if groups | grep -qv "docker"; then
    echo "Creating docker group & adding $USER to docker group."
    sudo groupadd docker || sudo newgrp docker &&
    echo
  echo "Adding $USER to docker group."
  sudo usermod -aG docker $USER
  fi
EOF
echo

# Run web app. Group nohup command with { } so ONLY that 1 command runs in background.
echo "Running Docker Compose command to start app..."
echo
ssh -i "${PEM_KEY}" ubuntu@"${IP_ADDR}" -- docker compose up -d
echo
# In a Browser Tab: See the running app at the IP address, e.g., http://IPaddress:48019