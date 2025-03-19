FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

# Fix nvidia-key error issue (NO_PUBKEY A4B469963BF863CC)
RUN rm /etc/apt/sources.list.d/*.list

# Installing apt packages
RUN export DEBIAN_FRONTEND=noninteractive && apt -y update --no-install-recommends && apt -y install --no-install-recommends git wget tmux vim zsh build-essential cmake ninja-build libopenblas-dev libsparsehash-dev && apt autoremove -y && apt clean -y

# Installing requirements apart from copying whole repo (not to rebuild image when small changes occur)
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY . /dvlo_workspace/DVLO/
WORKDIR /dvlo_workspace/DVLO
RUN chmod +x docker/post-build.sh


