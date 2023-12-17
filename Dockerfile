FROM ruby:2.4.4

# Atualizar os pacotes e instalar as dependências
# RUN apt-get update -qy --force-yes --allow-unauthenticated

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
    libgdbm3  \
    libpq-dev

# Limpar o cache do apt-get e outros arquivos temporários
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define o diretório de trabalho
RUN mkdir -p app
COPY Gemfile /app
WORKDIR /app
RUN bundle install

# Tratamento de erros
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["sh","/usr/local/bin/docker-entrypoint.sh"]
