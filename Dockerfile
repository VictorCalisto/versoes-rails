FROM ruby:2.7.0

# Atualizar os pacotes e instalar as dependências
RUN apt-get update -y

# Instala dependencias
RUN apt-get install -qy --no-install-recommends \
    curl \
    gpg \
    autoconf  \
    bison  \
    build-essential  \
    libssl-dev  \
    libyaml-dev  \
    libreadline6-dev  \
    zlib1g-dev  \
    libncurses5-dev  \
    libffi-dev  \
    libgdbm6  \
    libgdbm-dev \
    libpq-dev \
    postgresql-client

# Instalar o Rails
RUN /bin/bash -l -c "gem install net-imap -v 0.3.7"
RUN /bin/bash -l -c "gem install rails -v 6.0.3.2"

# Define o diretório de trabalho
WORKDIR /app

# Limpar o cache do apt-get e outros arquivos temporários
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tratamento de erros
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#CMD ["sh", "-c", "sleep infinity"]
ENTRYPOINT ["sh","/usr/local/bin/docker-entrypoint.sh"]
