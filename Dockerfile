FROM python:3.7-slim-buster
#FROM gcr.io/data-development-254912/gcp_bi_baseimage 
#FROM gcp_bi_baseimage
LABEL maintainer = "Krystian Osiekowicz" 
ENV APP_HOME /app 
WORKDIR $APP_HOME
COPY / ./
# install nano 
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        apt-utils \
        apt-transport-https \
        curl \
        gnupg \
        unixodbc-dev \ 
        gcc \
        g++ \ 
        nano \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql17 \
    && apt-get install libgssapi-krb5-2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
    && pip install pyodbc==4.0.28 google-cloud-bigquery==1.24.0 google-cloud-storage==1.26.0
