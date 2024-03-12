# Usa la imagen base de Nginx
FROM nginx:alpine

# Elimina el archivo de configuración por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia los archivos estáticos de tu aplicación Flutter web al directorio de Nginx
COPY build/web /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

# Inicia Nginx en primer plano cuando se ejecute el contenedor
CMD ["nginx", "-g", "daemon off;"]

