FROM node:14

# Create a working directory
WORKDIR /app

# Create a non-root user and group
RUN groupadd -r appgroup && useradd -r -g appgroup -d /home/appuser -m appuser

# Create the home directory for the user and adjust permissions
RUN mkdir -p /home/appuser/.npm && chown -R appuser:appgroup /home/appuser

# Copy package files and change permissions
COPY package*.json ./
RUN chown -R appuser:appgroup /app

# Configure npm to use the cache directory in the user's home
RUN npm config set cache /home/appuser/.npm --global

# Install dependencies, including devDependencies
RUN npm install

# Install mocha globally
RUN npm install -g mocha

# Copy the rest of the application and change permissions
COPY --chown=appuser:appgroup . .

# Fix permissions on the npm cache directory
RUN chown -R appuser:appgroup /home/appuser/.npm

# Switch to the new user
USER appuser

# Expose the application port
EXPOSE 3000

# Default command to run the application
CMD ["node", "index.js"]
