# First stage
FROM python:3.8-slim AS builder
# This is set to avoid sending .git to the Docker image
ARG ASREVIEW_VERSION=0+unknown
WORKDIR /asreview-${ASREVIEW_VERSION}

# Copy and build asreview
COPY . /asreview-${ASREVIEW_VERSION}
RUN pip3 install --upgrade pip setuptools \
    && pip3 install --user .

# Second stage
FROM python:3.8-slim

COPY --from=builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH
ENV ASREVIEW_PATH=project_folder

ENTRYPOINT ["asreview", "lab", "--ip", "0.0.0.0"]
