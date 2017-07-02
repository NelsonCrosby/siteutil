FROM python:3.6-alpine

WORKDIR /_build
ADD https://caddyserver.com/download/linux/amd64?plugins=http.ipfilter,http.ratelimit caddy.tgz
RUN tar -xzvf caddy.tgz && chmod +x caddy

WORKDIR /site

RUN cp /_build/caddy . && rm -rvf /_build

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY Caddyfile ./
RUN /site/caddy -validate

COPY . .

EXPOSE 2015
CMD [ "/site/caddy", "-log", "stderr" ]
