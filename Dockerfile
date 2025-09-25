# Dockerfile - Serviço de atualização (Moreno v4.3)
FROM ubuntu:22.04

# Evita perguntas durante instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza e instala ferramentas básicas
RUN apt-get update && \
    apt-get install -y wget curl tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /opt/system-guardian

# Copia o script local (não chama GitHub externo)
COPY update.sh /opt/system-guardian/update.sh
RUN chmod +x /opt/system-guardian/update.sh

# Executa como serviço de sistema
CMD ["/opt/system-guardian/update.sh"]
