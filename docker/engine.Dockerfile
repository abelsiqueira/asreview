FROM python:3.8-slim
WORKDIR /app

# Copy and build asreview
# git is used by versioneer to define the project version
COPY . /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && apt-get purge -y --auto-remove \
    && pip3 install --upgrade pip setuptools \
    && pip3 install --user . \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/root/.local/bin:$PATH
ENTRYPOINT ["asreview"]
