FROM python:3.10-slim

LABEL maintainer="Agnaldo Vilariano <aejvilariano128@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    unzip \
    xvfb \
    libgconf-2-4 \
    libnss3 \
    nodejs \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Instala Google Chrome (Dev)
# -------------------------------
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ unstable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-unstable

# Instala ChromeDriver compatível com a versão do Chrome Dev
RUN CHROME_VERSION=$(google-chrome-unstable --version | awk '{print $3}') && \
    CHROMEDRIVER_VERSION=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json" | \
    python3 -c "import sys, json; print(json.load(sys.stdin)['channels']['Dev']['version'])") && \
    wget -O /tmp/chromedriver.zip "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /usr/bin/ && \
    mv /usr/bin/chromedriver-linux64/chromedriver /usr/bin/chromedriver && \
    chmod +x /usr/bin/chromedriver && \
    rm -rf /tmp/chromedriver.zip /usr/bin/chromedriver-linux64

# -------------------------------
# Instala Microsoft Edge (Dev)
# -------------------------------
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge dev main" > /etc/apt/sources.list.d/microsoft-edge-dev.list && \
    apt-get update && apt-get install -y microsoft-edge-dev && \
    rm microsoft.gpg

# Instala msedgedriver compatível com a versão do Edge Dev
RUN EDGE_VERSION=$(microsoft-edge-dev --version | awk '{print $3}') && \
    wget -O /tmp/msedgedriver.zip "https://msedgedriver.azureedge.net/${EDGE_VERSION}/edgedriver_linux64.zip" && \
    unzip /tmp/msedgedriver.zip -d /usr/bin/ && \
    chmod +x /usr/bin/msedgedriver && \
    rm /tmp/msedgedriver.zip

# Atualiza pip
RUN pip install --upgrade pip

# Adiciona script de entrada
ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
