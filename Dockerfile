# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install core Linux utilities
RUN apt-get update && \
    apt-get install -y \
      bash \
      coreutils \
      findutils \
      grep \
      sed \
      gawk \
      util-linux \
      procps \
      net-tools \
      iproute2 \
      file \
      tree \
      diffutils \
      tar \
      gzip \
      bzip2 \
      xz-utils \
      locales \
      passwd \
    && rm -rf /var/lib/apt/lists/*

# Create puzzle + sessions dirs
RUN mkdir -p /puzzle-template /sessions

# Copy puzzle template into container
COPY puzzle-template/ /puzzle-template/

# Copy all admin scripts
COPY start-session.sh /usr/local/bin/start-session.sh
COPY stop-session.sh /usr/local/bin/stop-session.sh
COPY list-sessions.sh /usr/local/bin/list-sessions.sh
COPY cleanup-sessions.sh /usr/local/bin/cleanup-sessions.sh
COPY rotate-puzzle.sh /usr/local/bin/rotate-puzzle.sh
COPY session-info.sh /usr/local/bin/session-info.sh
COPY get-score.sh /usr/local/bin/add-score.sh

# Secure scripts: root only
RUN chmod 700 /usr/local/bin/*.sh && \
    chown root:root /usr/local/bin/*.sh

# Default command when container starts
CMD ["/bin/bash"]
