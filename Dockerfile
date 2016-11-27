FROM attensee/s3_website

# install nodejs
#
# credit: https://github.com/dockerfile/nodejs/blob/master/Dockerfile
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

ENV PATH $PATH:/nodejs/bin

RUN node -v
RUN npm -v

# Configure for s3_website usage
#
# credit: https://hub.docker.com/r/attensee/s3_website/~/dockerfile/
ENTRYPOINT ["s3_website"]