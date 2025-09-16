## Ferramentas

Com essa solução, você consegue instalar:

- <b>Typebot</b>

## Instalação

<p>Primeira instalação na minha VPS:</p>

```
sudo apt upgrade -y && sudo apt update && sudo apt install -y git && git clone https://github.com/Mellosre/autotypebot.git && cd autotypebot && sudo chmod +x install.sh && ./install.sh
```

<p>Já tenho uma instalação na minha VPS (para quem quer instalar outra aplicação):</p>

```
sudo apt upgrade -y && sudo apt update && cd autotypebot && git stash && git pull && chmod +x install.sh && ./install.sh
```
