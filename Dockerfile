FROM ruby:2.7.3

# Atualizar os pacotes
RUN apt-get update -qy --force-yes --allow-unauthenticated

# Instala dependencias
RUN apt-get install -qy --force-yes --no-install-recommends --allow-unauthenticated \
    curl \
    gpg \
    autoconf  \
    libssl-dev  \
    libyaml-dev  \
    libreadline6-dev  \
    zlib1g-dev  \
    libncurses5-dev  \
    libffi-dev  \
    libgdbm6  \
    libpq-dev \
    nodejs

# Instalar o Rails
RUN /bin/bash -l -c "gem install rails -v 5.2.8"

# Define o diretório de trabalho
WORKDIR /app

# Limpar o cache do apt-get e outros arquivos temporários
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tratamento de erros
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["sh","/usr/local/bin/docker-entrypoint.sh"]
#CMD ["sh", "-c", "sleep infinity"]