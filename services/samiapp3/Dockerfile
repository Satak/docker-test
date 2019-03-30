FROM python:3.7-alpine
COPY ["requirements.txt", "src/", "/app/"]
WORKDIR /app
RUN pip install -r requirements.txt
RUN apk add --no-cache tini=0.18.0-r0
RUN addgroup -S app && adduser -S app -G app
USER app:app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["gunicorn", "-b", "0.0.0.0:8080", "-w", "10", "main:app"]
