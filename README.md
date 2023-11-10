## ✨ Ferramentas

Com essa solução, você consegue instalar:

- <b>Typebot</b>

## 💽 Instalação

Não são muitos passos para utilizar essa solução, mas é importante prestar atenção em cada detalhe para evitar ter dor de cabeça por eventuais problemas.

<p>Primeira instalação na minha VPS:</p>

```
sudo apt upgrade -y && sudo apt update && sudo apt install -y git && git clone https://github.com/Sua-Startup/SetupInstallTypebot.git && cd SetupInstallTypebot && sudo chmod +x install.sh && ./install.sh
```

<p>Já tenho uma instalação na minha VPS (para quem quer instalar outra aplicação):</p>

```
sudo apt upgrade -y && sudo apt update && cd SetupInstallTypebot && git stash && git pull && chmod +x install.sh && ./install.sh
```
