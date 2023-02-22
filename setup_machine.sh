#! /bin/bash

# SCRIPT NAME: setup_machine.sh

# DESCRIPTION: This script is called by main.sh. It sets up the web server on 
# the Deployment Machine/AWS, including installing Docker and Docker Compose on
# AWS, i.e., sets up EC2 instance for deployment of web app on AWS.

# AUTHOR: Kim Lew

set -ex

ROOT_DIR='/home/ubuntu'
PROJECT_DIR='rails_buy_stuff'

check_current_directory () {
  if [ ! -d "${THE_DIR}" ]; then
    cd "${THE_DIR}"
  fi
}

check_existing_project_directory () {
  if [ -d "${ROOT_DIR}"/"${PROJECT_DIR}" ]; then
    echo "A previous " "${PROJECT_DIR}" "exists. Removing it for a clean start state."
    echo 'The directory path is: ' "${ROOT_DIR}"/"${PROJECT_DIR}"
    rm -r "${ROOT_DIR:?}"/"${PROJECT_DIR}"
  fi
}

# Check if nano already installed & install if not.
check_if_nano_installed () {
  if ! command -v nano &> /dev/null; then
    sudo apt install nano -y
  fi
}

echo
echo "INSTALLING required packages plus Docker & Docker Compose ON VM on AWS..."
check_current_directory "${ROOT_DIR}"
check_existing_project_directory

sudo apt update && sudo apt upgrade -y
check_if_nano_installed

# --- Docker Installation ---
# Refer to: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

# Install a few prerequisite packages which let apt use packages over HTTPS.
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo "CHECKING curl version, which is needed to add GPG key..."
curl --version
echo

echo "ADDING official GPG key for the official Docker repository to your system..."
sudo mkdir -p /etc/apt/keyrings
GPG_KEY='/etc/apt/keyrings/docker.gpg'

if [ -f "${GPG_KEY}" ]; then
    echo "${GPG_KEY} exists. Removing for clean start state."
    sudo rm "${GPG_KEY}"
fi

# --batch - to disallow interactive commands, gets rid of error,
# gpg: cannot open '/dev/tty': No such device or address
# -f --recipient-file file. This option is similar to --recipient except that it
# encrypts to a key stored in the given file.  file must be the name of a file 
# containing exactly 1 key. gpg assumes that the key in this file is fully valid.
# -s - silent
# -S - Show error
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --dearmor -o "${GPG_KEY}"
sudo apt update -y
sudo chmod a+r "${GPG_KEY}"
echo

echo "ADDING the Docker repository to APT sources to set up the repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=${GPG_KEY}] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo
# Update packages again for the new packages to be recognized.
sudo apt update -y

echo "VERIFYING Docker to be installed is from Docker repo for Ubuntu 22.04"
# Make sure you are about to install from the Docker repo vs. the default Ubuntu
# repo, i.e., checks that the candidate for installation is from the Docker
# repository for Ubuntu 22.04 (jammy).
apt-cache policy docker-ce
echo

echo "INSTALLING the Docker"
# Once installed, the daemon started & the process enabled to start on boot.
sudo apt install docker-ce -y
echo

# Check that Docker is running. If not, start Docker. If Docker is installed, 
# the daemon is started & the process is enabled to start on boot.
echo "CHECKING Docker version & Docker STARTED after installation: "
docker -v
sudo service docker status || sudo service docker start
sudo chmod u+x /var/run/docker.sock
echo

# --- Docker Compose Installation ---
mkdir -p ~/.docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose
echo "CHECK Docker Compose version installed: "
docker compose version
echo

# --- Login to Docker Hub ---
# echo "$DOCKER_REGISTRY_PASS" | docker login $DOCKER_REGISTRY --username $DOCKER_REGISTRY_USER --password

# At this point at the end of this script, you are passed back to main.sh & onto
# next command with ssh & docker compose up (which in turn, runs launch_app.sh 
# from the Dockerfile, which runs the Buy Stuff web app).