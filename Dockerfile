# # Install ruby 
# FROM ruby:2.6.2

# # MAINTAINER name and e-mail address
# MAINTAINER Agnaldo Vilariano <aejvilariano128@gmail.com>

# ENV DEBIAN_FRONTEND noninteractive

# RUN gem install bundler

# # Install dependencies
# RUN apt-get update && apt-get -y install wget xvfb unzip libgconf2-4 libnss3 nodejs

# # Install Chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# RUN apt-get update && apt-get -y install google-chrome-stable

# # install chromedriver com versão sempre LATEST_RELEASE
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip \
#     && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
#     && chmod ugo+rx /usr/bin/chromedriver

# ADD docker-entrypoint.sh /
# ENTRYPOINT ["/docker-entrypoint.sh"]

###teste###
ARG RUBY_VERSION=2.6.2
FROM ruby:${RUBY_VERSION}

MAINTAINER Agnaldo Vilariano <aejvilariano128@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV CHROMIUM_DRIVER_VERSION 85.0.4183.87
ENV CHROME_VERSION 85.0.4183.102

RUN gem install bundler


# Install dependencies
# RUN apt-get update && apt-get -y install wget xvfb unzip libgconf2-4 libnss3 nodejs

# # Install Chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# RUN apt-get update && apt-get -y install google-chrome-stable=$CHROME_VERSION

# # install chromedriver com versão sempre LATEST_RELEASE
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION`/chromedriver_linux64.zip \
#     && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
#     && chmod ugo+rx /usr/bin/chromedriver

# Install dependencies & Chrome
RUN apt-get update && apt-get -y --no-install-recommends install zlib1g-dev liblzma-dev wget xvfb unzip libgconf2-4 libnss3 nodejs \
 && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -  \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
 && apt-get update && apt-get -y --no-install-recommends install google-chrome-stable=$CHROME_VERSION \
 && rm -rf /var/lib/apt/lists/*

# Install Chrome driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod ugo+rx /usr/bin/chromedriver \
    && apt-mark hold google-chrome-stable

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
