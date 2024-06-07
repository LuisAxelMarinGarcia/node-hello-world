FROM node:14

# Crear un directorio de trabajo
WORKDIR /app

# Crear un usuario y grupo no-root
RUN groupadd -r appgroup && useradd -r -g appgroup -d /home/appuser appuser

# Crear el directorio de inicio para el usuario y ajustar permisos
RUN mkdir /home/appuser && chown -R appuser:appgroup /home/appuser

# Copiar y cambiar permisos de archivos
COPY package*.json ./
RUN chown -R appuser:appgroup /app

# Cambiar al nuevo usuario
USER appuser

# Instalar dependencias
RUN npm install

# Copiar el resto de la aplicación
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando por defecto para correr la aplicación
CMD ["node", "index.js"]
