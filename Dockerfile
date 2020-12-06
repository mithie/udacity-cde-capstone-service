FROM python:3.7.3-stretch

WORKDIR /app

COPY app.py requirements.txt /app/

RUN pip install --upgrade pip==20.3.1 &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 9090

CMD ["python", "app.py"]
