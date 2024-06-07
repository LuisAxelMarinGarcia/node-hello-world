# Utilizar la imagen base de Node.js versión 14
FROM node:14

# Crear un directorio de trabajo
WORKDIR /app

# Crear un usuario y grupo no-root
RUN groupadd -r appgroup && useradd -r -g appgroup -d /home/appuser -m appuser

# Copiar los archivos package.json y package-lock.json al directorio de trabajo
COPY package*.json ./

# Cambiar la propiedad de los archivos copiados al nuevo usuario y grupo
RUN chown -R appuser:appgroup /app /home/appuser

# Cambiar al nuevo usuario para evitar problemas de permisos
USER appuser

# Instalar las dependencias de la aplicación
RUN npm install

# Copiar el resto de los archivos de la aplicación al directorio de trabajo
COPY . .

# Exponer el puerto 3000 para acceder a la aplicación
EXPOSE 3000

# Comando por defecto para ejecutar la aplicación
CMD ["node", "index.js"]
