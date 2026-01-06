FROM codeberg.org/forgejo/forgejo:13-rootless AS forgejo

FROM ghcr.io/hassio-addons/base:19.0.0
RUN apk --no-cache add \
    bash \
    ca-certificates \
    dumb-init \
    gettext \
    git \
    curl \
    gnupg \
    openssh-client
COPY --from=forgejo --chown=root:root /app/gitea/gitea /app/gitea/gitea
COPY --from=forgejo --chown=root:root /usr/local/bin/environment-to-ini /usr/local/bin/environment-to-ini
COPY --from=forgejo --chown=root:root /usr/local/bin/docker-setup.sh /usr/local/bin/docker-setup.sh
COPY --from=forgejo --chown=root:root /etc/templates/app.ini /etc/templates/app.ini

RUN addgroup \
    -S -g 1000 \
    git && \
  adduser \
    -S -H -D \
    -h /var/lib/gitea/git \
    -s /bin/bash \
    -u 1000 \
    -G git \
    git

RUN mkdir -p /var/lib/gitea /etc/gitea
RUN chown git:git /var/lib/gitea /etc/gitea

COPY /data /
RUN chmod +x /run.sh

#git:git
USER 1000:1000
ENV GITEA_WORK_DIR=/var/lib/gitea
ENV GITEA_CUSTOM=/var/lib/gitea/data
ENV GITEA_TEMP=/tmp/gitea
ENV TMPDIR=/tmp/gitea

ENV GITEA_APP_INI=${GITEA_CUSTOM}/conf/app.ini
ENV HOME="/var/lib/gitea/git"
VOLUME ["/var/lib/gitea", "/etc/gitea"]
WORKDIR /var/lib/gitea

EXPOSE 3000 22
CMD ["/run.sh"]
