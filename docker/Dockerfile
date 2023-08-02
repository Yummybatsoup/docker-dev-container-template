# FROM ubuntu:20.04
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ARG USER_ID
ARG GROUP_ID
ARG USER
ARG GROUP

ENV DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_TOKEN=easy

RUN apt -y update
RUN apt -y install git
# opencv required
RUN apt -y install ffmpeg libsm6 libxext6
# for training
RUN apt -y install screen tmux

RUN apt -y install python3-pip
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN apt clean

# map user
RUN apt -y install sudo
RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
        groupadd -g ${GROUP_ID} ${GROUP} && \
        useradd -l -u ${USER_ID} -g ${GROUP} ${USER} && \
        install -d -m 0755 -o ${USER} -g ${GROUP} /home/${USER} && \
        usermod -aG sudo ${USER} && \
        echo "${USER}:${USER}" | chpasswd && \
        chown ${USER_ID}:${GROUP_ID} /home/${USER} \
    ;fi
        
USER ${USER}

COPY --chown=${USER} --chmod=+x entrypoint.sh .
CMD ./entrypoint.sh