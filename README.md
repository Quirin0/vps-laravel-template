
# Guia Completo para Subir Projeto Laravel em VPS com Portainer e Traefik

Este guia explica passo a passo como configurar sua VPS para rodar um projeto Laravel utilizando Docker, Portainer e Traefik, facilitando o gerenciamento e deploy dos seus projetos.

---

## Pré-requisitos

- VPS com acesso root ou sudo  
- Domínio registrado com acesso para configurar DNS  
- Conhecimento básico de Linux e Docker  

---

## Passo 1: Configurar DNS

- Acesse o painel do seu provedor de domínio.  
- Crie um registro **A** apontando o domínio desejado para o IP da sua VPS.

Exemplo:

| Tipo | Nome              | Valor          |
|-------|-------------------|----------------|
| A     | api.seuprojeto.com | 103.XX.XX.XX   |

> Aguarde a propagação do DNS (pode levar até 24h, mas geralmente é mais rápido).

---

## Passo 2: Instalar Portainer + Traefik

1. Conecte-se à sua VPS via SSH.  
2. Execute o instalador oficial simplificado:

```bash
bash <(curl -sSL setup.oriondesign.art.br)
```

> **Importante:**  
> Durante a instalação, defina o nome da rede do Portainer como `traefik`. Essa configuração é fundamental para o roteamento correto dos containers.

---

## Passo 3: Configurar Template Laravel no Portainer

1. Acesse o painel do Portainer pelo navegador (`http://IP-da-VPS:9000`).  
2. Vá em **Templates** → **Custom Templates** → **Git Repository**.  
3. Cole o link do repositório:

```
https://github.com/Quirin0/vps-laravel-template
```

4. O Portainer importará um template pronto, configurado para rodar o Laravel com Traefik e Docker.

---

## Passo 4: Preparar diretórios para o projeto

1. No terminal da VPS, crie a estrutura de pastas para organizar seus projetos e configurações:

```bash
mkdir -p ~/domains/nginx
```

2. Baixe o arquivo `default.conf` do repositório e coloque dentro da pasta `~/domains/nginx/`.

Esse arquivo contém as configurações do Nginx usadas pelo Traefik para servir seu projeto Laravel.

---

## Passo 5: Adicionar seu projeto Laravel

1. Dentro da pasta `~/domains/`, crie uma pasta para seu domínio/projeto Laravel:

```bash
mkdir ~/domains/api.seuprojeto.com
```

2. Copie o código do seu projeto Laravel para essa pasta.  
3. Certifique-se que o `Dockerfile` presente no repositório está dentro dessa pasta (é o Dockerfile customizado para Laravel PHP 8.2).

---

## Passo 6: Construir a imagem Docker do projeto Laravel

Entre na pasta do projeto:

```bash
cd ~/domains/api.seuprojeto.com
```

Construa a imagem personalizada com:

```bash
docker build -t laravel-php-custom:8.2 .
```

---

## Passo 7: Criar a Stack no Portainer

1. No painel do Portainer, crie uma nova **Stack** usando o template importado.  
2. Aponte para a pasta do projeto (`~/domains/api.seuprojeto.com`).  
3. Configure as variáveis de ambiente conforme necessário.  
4. Salve e suba a stack.

---

## Passo 8: Acessar sua aplicação Laravel

- Sua aplicação estará disponível no domínio configurado (exemplo: `https://api.seuprojeto.com`).  
- Traefik cuidará do roteamento HTTPS automaticamente.

---

## Dicas importantes

- Você pode repetir o processo para múltiplos projetos criando novas pastas dentro de `~/domains/` e stacks no Portainer.  
- Para atualizar o projeto, atualize os arquivos na pasta e reconstrua a imagem Docker.  
- Utilize os logs do Portainer para monitorar o funcionamento.  
- Sempre faça backup do seu código e banco de dados.

---

## Resumo dos comandos úteis

```bash
mkdir -p ~/domains/nginx
mkdir ~/domains/api.seuprojeto.com

cd ~/domains/api.seuprojeto.com

docker build -t laravel-php-custom:8.2 .

bash <(curl -sSL setup.oriondesign.art.br)
```

---

Se precisar de ajuda para criar um `docker-compose.yml` ou otimizar ainda mais, é só avisar!

---

**Feito com ❤️ por Matheus Quirino**
