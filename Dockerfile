# First stage
FROM python:3.8-slim AS builder
WORKDIR /app

# Copy and build asreview
# git is used by versioneer to define the project version
COPY . /app
RUN apt-get update \
    && apt-get install -y git npm \
    && pip3 install --upgrade pip setuptools
RUN python3 setup.py compile_assets
RUN pip3 install --user .
RUN pip3 install --user asreview-datatools asreview-insights

# Second stage
FROM python:3.8-slim

COPY --from=builder /root/.local /root/.local

ENV ASREVIEW_HOST=0.0.0.0
ENV PATH=/root/.local/bin:$PATH
ENV ASREVIEW_PATH=project_folder
EXPOSE 5000

ENTRYPOINT ["asreview"]
