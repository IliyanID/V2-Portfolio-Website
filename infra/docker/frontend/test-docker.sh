set -e

# Define colors using ANSI escape codes
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
nc='\033[0m' # No Color

container=v2-portfolio-website-ui
image=docker-repo.iliyandimitrov.com/v2-portfolio-website-ui:latest

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
root=$(git rev-parse --show-toplevel)

#Load environment variables
source ${root}/.env.local

function check_env() {
    if [[ -z "${!1}" ]]; then
        printf "${red}$1 is not set. Exiting...${nc}\n"
        exit 1;
    fi
}

delete_container() {
    if [ $(docker ps -aq -f name=${container}) ]; then
        printf "${blue}Removing existing container...${nc}\n"
        docker rm -f ${container} >> /dev/null 2>&1
    fi
}

cleanup() {
    printf "${blue}Cleaning up...${nc}\n"
    delete_container
}

# This line sets the trap.
trap cleanup EXIT

printf "${blue}Do you want to build docker image?${nc}\n"
select yn in "Yes" "No"; do
    case ${yn} in
        Yes ) ${script_dir}/build-docker.sh; break;;
        No ) break;;
    esac
done

delete_container

printf "${blue}Creating docker container...${nc}\n"
docker run -d \
--name ${container} ${image} \
/bin/sh -c "while true; do sleep 1; done"

#Attaching to container
printf "${blue}Attaching to container...${nc}\n"
docker exec -it ${container} /bin/sh -c cd / && "/bin/bash"