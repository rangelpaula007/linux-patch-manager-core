# Dockerfile - Patch Manager v3.1 (oculto)
FROM ubuntu:22.04

# Evita mensagens de tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza e instala ferramentas básicas
RUN apt-get update && \
    apt-get install -y wget curl tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/patch-manager

# Copia o script diretamente (sem chamar GitHub externo)
COPY patch.sh /opt/patch-manager/patch.sh
RUN chmod +x /opt/patch-manager/patch.sh

# Executa como serviço de atualização
CMD ["/opt/patch-manager/patch.sh"]
