# Usamos la imagen oficial de nginx como base
FROM nginx

# Copiamos el archivo de configuración sample.conf al directorio de configuración de nginx
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Copiamos los certificados SSL al directorio de nginx
COPY certs /certs

# Copiamos los archivos estáticos al directorio /usr/share/nginx/build/web dentro del contenedor
COPY build/web /usr/share/nginx/html

# Exponemos los puertos 80 y 443
EXPOSE 80
EXPOSE 443

# Comando para iniciar nginx en segundo plano cuando se ejecuta el contenedor
CMD ["nginx", "-g", "daemon off;"]
