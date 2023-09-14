set -e

root=$(git rev-parse --show-toplevel)

# Load environment variables
source ${root}/.env.local

docker_image=docker-repo.iliyandimitrov.com/v2-portfolio-website-ui:latest
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function check_env() {
    if [[ -z "${!1}" ]]; then
        printf "${red}$1 is not set. Exiting...${nc}\n"
        exit 1;
    fi
}

ui_folder=${root}/frontend/build
function cleanup() {
    if [ -d ${ui_folder} ]; then
        printf "${blue}Removing existing build folder...${nc}\n"
        rm -rf ${ui_folder}
    fi
}
trap cleanup EXIT

if [ "${CI}" == "true" ] || { printf "\e[32mDo you want to build the UI?\e[0m\n" && select yn in "Yes" "No"; do case ${yn} in Yes ) break;; No ) exit 0;; esac; done; }; then
    (set -x; cd ${root}/frontend && pnpm build)
fi

if [ -d ${ui_folder} ]; then
    cp -r ${ui_folder} .
else
    printf "${red}Could not find UI build folder. Exiting...${nc}\n"
    exit 1
fi

printf "\e[33mBuilding ${docker_image}\e[0m\n"
(set -x; docker build --platform linux/x86_64 --no-cache -t ${docker_image} ${script_dir})

if [ "${CI}" == "true" ] || { printf "\e[32mDo you want to push ${docker_image}?\e[0m\n" && select yn in "Yes" "No"; do case ${yn} in Yes ) break;; No ) exit 0;; esac; done; }; then
    (set -x; docker push ${docker_image})
fi
