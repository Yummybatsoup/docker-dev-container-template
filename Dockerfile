FROM ubuntu:20.04

ARG USER_ID
ARG GROUP_ID
ARG USER
ARG GROUP

RUN apt -y update
RUN apt -y install git

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    groupadd -g ${GROUP_ID} ${GROUP} &&\
    useradd -l -u ${USER_ID} -g ${GROUP} ${USER} &&\
    install -d -m 0755 -o ${USER} -g ${GROUP} /home/${USER} &&\
    chown ${USER_ID}:${GROUP_ID} /home/${USER} \
    ;fi
        
USER ${USER}

CMD sleep infinity