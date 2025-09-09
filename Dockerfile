# Use imagem base com Python
FROM python:3.10-slim

# MAINTAINER name and e-mail address
LABEL maintainer="Agnaldo Vilariano <aejvilariano128@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV CHROME_DRIVER_VERSION=105.0.5195.52

# Atualiza pacotes e instala dependências
RUN apt-get update && apt-get install -y \
    wget \
    xvfb \
    unzip \
    libgconf-2-4 \
    libnss3 \
    nodejs \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Instala o Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable
# Instala o ChromeDriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ && \
    rm /tmp/chromedriver.zip && \
    chmod ugo+rx /usr/bin/chromedriver
# Instala pip e outras dependências Python se necessário
RUN pip install --upgrade pip

# Adiciona o script de entrada
ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
