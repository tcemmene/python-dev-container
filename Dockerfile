FROM python:latest
WORKDIR /app/src
COPY ./src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
CMD ["tail", "-f", "/dev/null"]

