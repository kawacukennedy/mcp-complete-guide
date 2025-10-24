FROM python:3.11-slim
WORKDIR /app
COPY examples/python_server/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY examples/python_server/ server/
EXPOSE 8080
CMD ["python","server/server.py"]
