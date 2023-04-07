# First stage
FROM ghcr.io/abelsiqueira/asreview-engine AS builder
WORKDIR /app

# Copy and build asreview
RUN apt-get update \
    && apt-get install -y --no-install-recommends npm \
    && apt-get purge -y --auto-remove \
    && python3 setup.py compile_assets \
    && pip3 install --user . \
    && rm -rf /var/lib/apt/lists/*

# Second stage
FROM python:3.8-slim

COPY --from=builder /root/.local /root/.local

ENV ASREVIEW_HOST=0.0.0.0
ENV PATH=/root/.local/bin:$PATH
ENV ASREVIEW_PATH=project_folder
EXPOSE 5000

ENTRYPOINT ["asreview", "lab"]
