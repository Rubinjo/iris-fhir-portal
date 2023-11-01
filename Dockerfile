ARG IMAGE=intersystemsdc/irishealth-community:latest
FROM $IMAGE

USER root

RUN mkdir -p /data/fhir
COPY /data/fhir /data/fhir

WORKDIR /irisrun/repo

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /irisrun/repo
USER ${ISC_PACKAGE_MGRUSER}

ARG NAMESPACE="USER"

ENV SRC_PATH=/irisrun/repo
ENV IRISUSERNAME "_SYSTEM"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
    iris session IRIS < iris.script && \
    iris stop IRIS quietly