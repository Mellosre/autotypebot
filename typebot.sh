#!/bin/bash

# #######################################################
#
# FUNÇÕES DE LOADING
#

# Função para exibir uma barra de progresso
# Argumentos: $1 = Mensagem, $2 = Largura da barra
show_progress() {
    local message=$1
    local width=$2
    local interval=0.02
    local progress=0

    while [ $progress -le 100 ]; do
        local bar=$(printf "[%-${width}s]" $(printf "=%.0s" $(seq 1 $(($progress * $width / 100)))))
        printf "\r\e[1;32m%s... %s %3d%%\e[0m" "$message" "$bar" "$progress"
        sleep $interval
        progress=$((progress + 1))
    done
    echo # Pula para a próxima linha
    sleep 1
}

# #######################################################
#
# CRÉDITOS E NOME DO PROGRAMA
#

clear
show_progress "Carregando Auto Instalador" 50
clear

echo -e "\e[97m\e[0m"
echo -e "\e[97m _______                         _                           _           _           \e[0m"
echo -e "\e[97m(_______)                       | |                         | |         | |           \e[0m"
echo -e "\e[97m _______  _   _  _| |_   ___    | | ____   ___   _| |_  _____ | | _____   __| |  ___   ____ \e[0m"
echo -e "\e[97m|  ___  || | | |(_   _) / _ \   | ||  _ \ /___)(_   _)(____ || | (____ | / _  | / _ \ / ___)\e[0m"
echo -e "\e[97m| |   | || |_| |  | |_ | |_| |  | || | | ||___ |  | |_ / ___ || | / ___ |( (_| || |_| || |    \e[0m"
echo -e "\e[97m|_|   |_||____/    \__) \___/   |_||_| |_|(___/    \__)\_____| \_)\_____| \____| \___/ |_|    \e[0m"
echo -e "\e[97m\e[33m\e[0m"
echo -e "\e[97m     _           _______                         _                  \e[0m"
echo -e "\e[97m    | |         (_______)                       | |           _     \e[0m"
echo -e "\e[97m  __| |  ___      _      _   _  ____   _____ | |__    ___   _| |_  \e[0m"
echo -e "\e[97m / _  | / _ \    | |    | | | ||  _ \ | ___ ||  _ \  / _ \ (_   _) \e[0m"
echo -e "\e[97m( (_| || |_| |   | |    | |_| || |_| || ____|| |_) )| |_| |  | |_  \e[0m"
echo -e "\e[97m \____| \___/    |_|     \__  ||  __/ |_____)|____/  \___/    \__) \e[0m"
echo -e "\e[97m                         (____/ |_|                               \e[0m"
echo -e "\e[97m\e[0m"

# #######################################################
#
# PERGUNTAS PARA VARIAVEIS
#

echo ""
echo -e "\e[93m==============================================================================\e[0m"
echo -e "\e[93m=                                                                            =\e[0m"
echo -e "\e[93m=               \e[1;33mPreencha as informações solicitadas abaixo\e[0m                 \e[93m=\e[0m"
echo -e "\e[93m=                                                                            =\e[0m"
echo -e "\e[93m==============================================================================\e[0m"
echo ""

echo -e "\e[93mPasso \e[33m1/13\e[0m"
read -p "Digite a versão que deseja instalar (ex: latest, main, 2.16.0): " version
version=${version:-latest} # Define 'latest' como padrão se nada for digitado

echo ""
echo -e "\e[93mPasso \e[33m2/13\e[0m"
read -p "Link do Builder (ex: typebot.seudominio.com): " builder
echo ""
echo -e "\e[93mPasso \e[33m3/13\e[0m"
read -p "Porta do Builder (padrão: 3001): " portabuilder
portabuilder=${portabuilder:-3001} # Padrão 3001
echo ""
echo -e "\e[93mPasso \e[33m4/13\e[0m"
read -p "Link do Viewer (ex: bot.seudominio.com): " viewer
echo ""
echo -e "\e[93mPasso \e[33m5/13\e[0m"
read -p "Porta do Viewer (padrão: 3002): " portaviewer
portaviewer=${portaviewer:-3002} # Padrão 3002
echo ""
echo -e "\e[93mPasso \e[33m6/13\e[0m"
read -p "Link do Storage (ex: storage.seudominio.com): " storage
echo ""
echo -e "\e[93mPasso \e[33m7/13\e[0m"
read -p "Porta do Storage (padrão: 9000): " portastorage
portastorage=${portastorage:-9000} # Padrão 9000
echo ""
echo -e "\e[93mPasso \e[33m8/13\e[0m"
read -p "Seu Email (para o SSL e admin): " email
echo ""
echo -e "\e[93mPasso \e[33m9/13\e[0m"
read -s -p "Senha do seu Email (se for gmail, use senha de app): " senha
echo ""
echo ""
echo -e "\e[93mPasso \e[33m10/13\e[0m"
read -p "SMTP do seu email (ex: smtp.gmail.com): " smtp
echo ""
echo -e "\e[93mPasso \e[33m11/13\e[0m"
read -p "Porta SMTP (ex: 465 ou 587): " portasmtp
echo ""
echo -e "\e[93mPasso \e[33m12/13\e[0m"
read -p "Usar SMTP_SECURE? (Se a porta for 465, digite 'true', caso contrário, 'false'): " SECURE
SECURE=${SECURE:-true} # Padrão true
echo ""
echo -e "\e[93mPasso \e[33m13/13\e[0m"
echo "Crie sua Chave Secreta em: https://codebeautify.org/generate-random-hexadecimal-numbers"
read -p "Chave secreta de 32 caracteres: " key

# #######################################################
#
# VERIFICAÇÃO DE DADOS
#

clear
echo -e "\e[1;33mPor favor, confirme os dados inseridos:\e[0m"
echo "--------------------------------------------------"
echo -e "Versão: \e[32m$version\e[0m"
echo -e "Link do Builder: \e[32m$builder\e[0m"
echo -e "Porta do Builder: \e[32m$portabuilder\e[0m"
echo -e "Link do Viewer: \e[32m$viewer\e[0m"
echo -e "Porta do Viewer: \e[32m$portaviewer\e[0m"
echo -e "Link do Storage: \e[32m$storage\e[0m"
echo -e "Porta do Storage: \e[32m$portastorage\e[0m"
echo -e "Seu Email: \e[32m$email\e[0m"
echo -e "SMTP do seu email: \e[32m$smtp\e[0m"
echo -e "Porta SMTP: \e[32m$portasmtp\e[0m"
echo -e "SMTP_SECURE: \e[32m$SECURE\e[0m"
echo -e "Chave secreta: \e[32m$key\e[0m"
echo "--------------------------------------------------"
echo ""
read -p "As informações estão corretas? (s/n): " confirma1

# #######################################################
#
# LÓGICA DE INSTALAÇÃO
#

if [[ "$confirma1" == "s" || "$confirma1" == "S" ]]; then
    clear
    echo -e "\e[1;32m _                           _                 \e[0m"
    echo -e "\e[1;32m| |                         | |                \e[0m"
    echo -e "\e[1;32m| | ____   ___   _| |_  _____ | | _____   ____   \e[0m"
    echo -e "\e[1;32m| ||  _ \ /___)(_   _)(____ || | (____ ||  _ \  \e[0m"
    echo -e "\e[1;32m| || | | ||___ |  | |_ / ___ || | / ___ || | | | \e[0m"
    echo -e "\e[1;32m|_||_| |_|(___/    \__)\_____| \_)\_____||_| |_| \e[0m"
    echo ""

    show_progress "Iniciando Instalação" 50

    # 1. INSTALANDO DEPENDENCIAS
    echo "=> Atualizando pacotes do sistema..."
    sudo apt-get update -y && sudo apt-get upgrade -y
    echo "=> Instalando Docker, Docker Compose, Nginx e Certbot..."
    sudo apt-get install docker.io docker-compose-v2 nginx certbot python3-certbot-nginx -y
    
    # 2. CRIANDO DIRETÓRIO E ARQUIVO DOCKER-COMPOSE
    echo "=> Configurando o ambiente do Typebot..."
    cd # Volta para o diretório home
    mkdir -p typebot.io
    cd typebot.io

    # Usando cat com 'EOF' para evitar problemas com caracteres especiais
    cat > docker-compose.yml << EOF
version: '3.8'

services:
  typebot-db:
    image: postgres:13
    restart: always
    volumes:
      - db_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=typebot
      - POSTGRES_USER=typebot
      - POSTGRES_PASSWORD=typebot

  typebot-builder:
    image: baptistearno/typebot-builder:${version}
    restart: always
    ports:
      - "${portabuilder}:3000"
    depends_on:
      - typebot-db
    environment:
      - DATABASE_URL=postgresql://typebot:typebot@typebot-db:5432/typebot
      - NEXTAUTH_URL=https://${builder}
      - NEXT_PUBLIC_VIEWER_URL=https://${viewer}
      - ENCRYPTION_SECRET=${key}
      - ADMIN_EMAIL=${email}
      - SMTP_HOST=${smtp}
      - SMTP_PORT=${portasmtp}
      - SMTP_USERNAME=${email}
      - SMTP_PASSWORD=${senha}
      - SMTP_SECURE=${SECURE}
      - NEXT_PUBLIC_SMTP_FROM='Suporte Typebot <${email}>'
      - S3_ACCESS_KEY=minio
      - S3_SECRET_KEY=minio123
      - S3_BUCKET=typebot
      - S3_ENDPOINT=http://minio:9000
      - S3_REGION=us-east-1

  typebot-viewer:
    image: baptistearno/typebot-viewer:${version}
    restart: always
    ports:
      - "${portaviewer}:3000"
    depends_on:
      - typebot-db
    environment:
      - DATABASE_URL=postgresql://typebot:typebot@typebot-db:5432/typebot
      - NEXTAUTH_URL=https://${builder}
      - NEXT_PUBLIC_VIEWER_URL=https://${viewer}
      - ENCRYPTION_SECRET=${key}
      - S3_ACCESS_KEY=minio
      - S3_SECRET_KEY=minio123
      - S3_BUCKET=typebot
      - S3_ENDPOINT=http://minio:9000
      - S3_REGION=us-east-1

  minio:
    image: minio/minio:latest
    restart: always
    ports:
      - "${portastorage}:9000"
    environment:
      - MINIO_ROOT_USER=minio
      - MINIO_ROOT_PASSWORD=minio123
    volumes:
      - s3_data:/data
    command: server /data

  createbuckets:
    image: minio/mc
    depends_on:
      - minio
    entrypoint: >
      /bin/sh -c "
      sleep 10;
      /usr/bin/mc config host add minio http://minio:9000 minio minio123;
      /usr/bin/mc mb minio/typebot;
      /usr/bin/mc policy set public minio/typebot;
      exit 0;
      "

volumes:
  db_data:
  s3_data:
EOF

    # 3. INICIANDO CONTAINERS
    echo "=> Iniciando os containers do Docker... (Isso pode levar alguns minutos)"
    sudo docker compose up -d

    # 4. CONFIGURANDO O NGINX (PROXY REVERSO)
    echo "=> Configurando o Nginx..."
    
    # Config para o Builder
    sudo bash -c "cat > /etc/nginx/sites-available/typebot << EOL
server {
    server_name ${builder};
    location / {
        proxy_pass http://127.0.0.1:${portabuilder};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL"

    # Config para o Viewer
    sudo bash -c "cat > /etc/nginx/sites-available/bot << EOL
server {
    server_name ${viewer};
    location / {
        proxy_pass http://127.0.0.1:${portaviewer};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL"

    # Config para o Storage
    sudo bash -c "cat > /etc/nginx/sites-available/storage << EOL
server {
    server_name ${storage};
    location / {
        proxy_pass http://127.0.0.1:${portastorage};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL"

    # 5. ATIVANDO OS SITES NO NGINX
    echo "=> Ativando as configurações no Nginx..."
    sudo ln -s -f /etc/nginx/sites-available/typebot /etc/nginx/sites-enabled/
    sudo ln -s -f /etc/nginx/sites-available/bot /etc/nginx/sites-enabled/
    sudo ln -s -f /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/
    
    # Testa a configuração e recarrega o Nginx
    sudo nginx -t && sudo systemctl reload nginx

    # 6. GERANDO CERTIFICADOS SSL
    echo "=> Gerando certificados SSL com Certbot..."
    sudo certbot --nginx --email $email --redirect --agree-tos -d $builder -d $viewer -d $storage --non-interactive

    # 7. MENSAGEM FINAL
    clear
    echo -e "\e[1;32m _                           _                 _   \e[0m"
    echo -e "\e[1;32m| |                         | |               | |  \e[0m"
    echo -e "\e[1;32m| | ____   ___   _| |_  _____ | | _____   ____  | |  \e[0m"
    echo -e "\e[1;32m| ||  _ \ /___)(_   _)(____ || | (____ ||  _ \ |_|  \e[0m"
    echo -e "\e[1;32m| || | | ||___ |  | |_ / ___ || | / ___ || | | | _   \e[0m"
    echo -e "\e[1;32m|_||_| |_|(___/    \__)\_____| \_)\_____||_| |_|(_)  \e[0m"
    echo ""
    echo -e "\e[1;33mInstalação concluída com sucesso!\e[0m"
    echo "--------------------------------------------------"
    echo -e "Acesse seu Typebot em: \e[1;34mhttps://$builder\e[0m"
    echo -e "O primeiro login será com o e-mail de admin: \e[1;34m$email\e[0m"
    echo "--------------------------------------------------"
    echo "Aguarde alguns minutos para que todos os serviços iniciem completamente."

elif [[ "$confirma1" == "n" || "$confirma1" == "N" ]]; then
    echo "Encerrando a instalação. Por favor, execute o script novamente."
    exit 0
else
    echo "Resposta inválida. Encerrando a instalação."
    exit 1
fi
