FROM docker/dev-environments-default:stable-1

RUN apt update
RUN apt install -y build-essential

# Install 'aws' client
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm -rf ./aws

# Install 'az' client
RUN  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install 'direnv'
RUN apt install -y direnv

# Install 'op' 1password client
RUN ARCH="amd64" && \
    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.0.0/op_linux_${ARCH}_v2.0.0.zip" -O op.zip && \
    unzip -d op op.zip && \
    sudo mv op/op /usr/local/bin && \
    rm -r op.zip op

USER vscode

# Install 'tfenv'
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv && \
    echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc

# Install 'nvmenv'
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
