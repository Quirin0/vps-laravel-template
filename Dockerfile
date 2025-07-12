# Dockerfile
FROM php:8.2-fpm

# Instala extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql

# Opcional: timezone e extensões úteis
RUN echo "date.timezone=America/Sao_Paulo" > /usr/local/etc/php/conf.d/timezone.ini