# First stage
FROM asreview/asreview-engine AS builder
WORKDIR /app

# Install other dependencies
RUN pip3 install --user asreview-datatools asreview-insights asreview-makita asreview-wordcloud

# Second stage
FROM python:3.8-slim

COPY --from=builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH
ENV ASREVIEW_PATH=project_folder

ENTRYPOINT ["asreview"]
