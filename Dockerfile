# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install Linux tools + Node.js
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
      curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create puzzle + sessions dirs
RUN mkdir -p /puzzle-template /sessions

# Copy puzzle template
COPY puzzle-template/ /puzzle-template/

# Copy all admin scripts
COPY scripts/ /usr/local/bin/
RUN chmod 700 /usr/local/bin/*.sh && chown root:root /usr/local/bin/*.sh

# Copy server code
WORKDIR /server
COPY server/package.json /server/
RUN npm install --omit=dev
COPY server/ /server/

# Expose API port
EXPOSE 5000

# Default command = start Express server
CMD ["npm", "start"]
