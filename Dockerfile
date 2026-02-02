# ===============================
# Stage 1: Build do front-end
# ===============================
FROM node:20-alpine AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia package.json e package-lock.json
COPY package*.json ./

# Instala dependências
RUN npm install

# Copia todos os arquivos do projeto
COPY . .

# Build da aplicação
RUN npm run build

# ===============================
# Stage 2: Image final com Nginx
# ===============================
FROM nginx:alpine

# Instala gettext (necessário para substituição de variáveis no entrypoint)
RUN apk add --no-cache gettext

# Copia a build do front-end para o Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copia o arquivo de configuração de ambiente
COPY public/env-config.js /usr/share/nginx/html/env-config.js

# Copia o entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Torna o entrypoint executável
RUN chmod +x /docker-entrypoint.sh

# Define o entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]