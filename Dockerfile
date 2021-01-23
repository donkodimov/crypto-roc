FROM python:3.8-slim

## Step 1:

WORKDIR /app
COPY requirements.txt /app/

## Step 2:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

## Step 3:
COPY . app.py logo.jpg /app/

## Step 4:
# Add git hash
ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}

## Step 4:
EXPOSE 8501

## Step 5:
CMD ["streamlit", "run", "app.py"]
