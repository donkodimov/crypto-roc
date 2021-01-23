FROM python:3.8-slim

## Step 1:

WORKDIR /app
COPY requirements.txt /app/

## Step 2:
# Add non-root user:

RUN useradd -m -r user && \
    chown user /app

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

## Step 4:
COPY . app.py logo.jpg /app/

## Step 5:
# Add git hash to container env and set user
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}
USER user

## Step 6:
EXPOSE 8501

## Step 7:
CMD ["streamlit", "run", "app.py"]
