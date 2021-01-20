FROM python:3.8-slim

## Step 1:

WORKDIR /app

## Step 2:
COPY . app.py logo.jpg /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

## Step 4:
EXPOSE 8501

## Step 5:
CMD ["streamlit", "run", "app.py"]
