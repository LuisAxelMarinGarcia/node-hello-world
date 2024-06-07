FROM node:14

# Crear un directorio de trabajo
WORKDIR /app

# Crear un usuario y grupo no-root
RUN groupadd -r appgroup && useradd -r -g appgroup -d /home/appuser -m appuser

# Crear el directorio de inicio para el usuario y ajustar permisos
RUN mkdir -p /home/appuser/.npm && chown -R appuser:appgroup /home/appuser

# Copiar y cambiar permisos de archivos
COPY package*.json ./
RUN chown -R appuser:appgroup /app

# Configurar npm para usar el directorio de caché en el home del usuario
RUN npm config set cache /home/appuser/.npm --global

# Instalar dependencias incluyendo las de desarrollo
RUN npm install

# Copiar el resto de la aplicación y cambiar permisos
COPY --chown=appuser:appgroup . .

# Cambiar permisos de todos los archivos en /home/appuser
RUN chown -R appuser:appgroup /home/appuser/.npm

# Cambiar al nuevo usuario
USER appuser

# Exponer el puerto
EXPOSE 3000

# Comando por defecto para correr la aplicación
CMD ["node", "index.js"]
