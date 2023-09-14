set -e

root=$(git rev-parse --show-toplevel)

#Load environment variables
source ${root}/.env.local

docker_image=docker-repo.iliyandimitrov.com/v2-portfolio-website-runner:latest
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function check_env() {
    if [[ -z "${!1}" ]]; then
        printf "${red}$1 is not set. Exiting...${nc}\n"
        exit 1;
    fi
}

check_env "RUNNER_TOKEN" 

printf "\e[33mBuilding ${docker_image}\e[0m\n"

(set -x; docker build --platform linux/x86_64 \
             --build-arg RUNNER_TOKEN=${RUNNER_TOKEN} \
             -t ${docker_image} ${script_dir})

printf "\e[32mDo you want to push ${docker_image}?\e[0m\n"
select yn in "Yes" "No"; do
    case ${yn} in
        Yes ) (set -x; docker push ${docker_image}); break;;
        No ) break;;
    esac
done