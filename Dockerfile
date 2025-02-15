ARG DOCKER_NGINX_CERTBOT_TAG=latest
FROM "jonasal/nginx-certbot:${DOCKER_NGINX_CERTBOT_TAG}"

ARG PIP_BREAK_SYSTEM_PACKAGES=1
ARG JINJANATOR_VERSION=25.1.0

# Add hostname to nginx logs, add jinjanator
RUN sed -i 's/\$remote_addr/$host \0/' /etc/nginx/nginx.conf \
    && pip install --no-cache-dir "jinjanator==${JINJANATOR_VERSION}"

COPY 25-jinja-on-templates.sh /docker-entrypoint.d/
