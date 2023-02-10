FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y python3 python3-pip ipython3-notebook \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache snap-stanford

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
