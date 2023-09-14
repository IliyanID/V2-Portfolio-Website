FROM ubuntu:latest

ARG RUNNER_TOKEN
ENV RUNNER_ALLOW_RUNASROOT="true"
ENV NODE_MAJOR=20


# Install needed packages
RUN apt-get update && apt-get install -y curl bash ca-certificates git gnupg 
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y
RUN npm install -g pnpm

# Prepare runner directory
RUN mkdir actions-runner
WORKDIR /actions-runner

# Download and verify runner
RUN curl -o actions-runner-linux-x64-2.309.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.309.0/actions-runner-linux-x64-2.309.0.tar.gz
RUN echo "2974243bab2a282349ac833475d241d5273605d3628f0685bd07fb5530f9bb1a  actions-runner-linux-x64-2.309.0.tar.gz" | sha256sum -c -
RUN tar xzf ./actions-runner-linux-x64-2.309.0.tar.gz

# Install .NET dependencies
RUN ./bin/installdependencies.sh

# Configure Runner
RUN ./config.sh --url https://github.com/IliyanID/V2-Portfolio-Website --token $RUNNER_TOKEN --name "V2 Portfolio Website Runner" -unattended --replace

# Cleanup
RUN rm -rf actions-runner-linux-x64-2.309.0.tar.gz

ENTRYPOINT ["/actions-runner/run.sh"]
