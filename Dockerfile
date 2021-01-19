FROM python:3.7.3-stretch

## Step 1:

WORKDIR /app

## Step 2:
COPY . app.py logo.jpg /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

## Step 4:
EXPOSE 8501

## Step 5:
CMD ["streamlit", "run", "app.py", "--server.enableCORS=false"]
