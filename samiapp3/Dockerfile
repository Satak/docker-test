FROM python:3.7-alpine
COPY ["requirements.txt", "src/", "/app/"]
WORKDIR /app
RUN pip install -r requirements.txt
USER nobody
CMD ["gunicorn", "-b", "0.0.0.0:8080", "-w", "10", "main:app"]
