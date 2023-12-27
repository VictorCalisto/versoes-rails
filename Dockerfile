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

# Instalando NodeJS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Adicione a chave GPG do Yarn e configure o repositório
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Atualize novamente o índice de pacotes e instale o Yarn
RUN apt-get update && apt-get install -y yarn

# Define o diretório de trabalho
WORKDIR /app

# Limpar o cache do apt-get e outros arquivos temporários
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tratamento de erros
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#CMD ["sh", "-c", "sleep infinity"]
ENTRYPOINT ["sh","/usr/local/bin/docker-entrypoint.sh"]
