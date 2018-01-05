FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y nginx \
    && apt-get install -y python-pip \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

COPY . /docker_test
WORKDIR /docker_test

RUN pip install --upgrade pip
RUN pip install -r pip-requirements.txt

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/conf.d/

COPY uwsgi.ini /etc/uwsgi/

ENV UWSGI_INI /app/uwsgi.ini

ENTRYPOINT ["python"]

EXPOSE 80
CMD ["nginx", "docker_test/app.py"]