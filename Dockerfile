FROM alpine

# Install OpenSSH
RUN apk add --no-cache dumb-init openssh-server rsync && \
    mv /etc/ssh/sshd_config /etc/ && \
    sed -e 's/#\(PasswordAuthentication\).*/\1 no/' \
        -e 's/#\(PermitRootLogin\).*/\1 no/' \
        -e '/^AuthorizedKeysFile/ s/$/ \/authorized_keys/' \
        -i /etc/sshd_config

VOLUME /etc/ssh

# Add user
RUN adduser -D ssh

# Expose SSH TCP port
EXPOSE 22/tcp

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/sshd_config"]
