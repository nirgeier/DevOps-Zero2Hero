# Use slimmed-down version of Node 23 (recommended for security)
FROM node:23-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Expose the port your app listens on
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]