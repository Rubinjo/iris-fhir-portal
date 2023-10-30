ARG IMAGE=intersystemsdc/irishealth-community:latest
FROM $IMAGE

WORKDIR /irisrun/repo

ARG NAMESPACE="USER"

ENV SRC_PATH=/irisrun/repo
ENV IRISUSERNAME "_SYSTEM"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE "USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
    iris session IRIS < iris.script && \
    iris stop IRIS quietly