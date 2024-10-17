ARG DOCKER_NGINX_CERTBOT_TAG=latest
FROM "jonasal/nginx-certbot:latest" AS final

ARG PIP_BREAK_SYSTEM_PACKAGES=1
ARG JINJANATOR_VERSION=24.4.0

# Add hostname to nginx logs, add jinjanator
RUN sed -i 's/\$remote_addr/$host \0/' /etc/nginx/nginx.conf \
    && pip install --no-cache-dir "jinjanator==${JINJANATOR_VERSION}"

COPY 25-jinja2-on-templates.sh /docker-entrypoint.d/
