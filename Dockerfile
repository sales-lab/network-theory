FROM ubuntu:18.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends python3-pip jupyter-notebook \
      libgomp1 curl python3-numpy python3-matplotlib python3-tqdm \
      python3-sklearn \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache snap-stanford

ARG NB_USER=jovyan
ARG NB_UID=1001
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}

RUN curl --silent --fail --remote-name \
      'http://snap.stanford.edu/pathways/bio-pathways-network.tar.gz' \
 && tar -xf bio-pathways-network.tar.gz bio-pathways-network.csv \
 && tr '\r' '\n' <bio-pathways-network.csv | tail -n +2 >network.csv \
 && rm bio-pathways-network*
