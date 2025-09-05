FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy built application
COPY dist/ ./

# Expose port
EXPOSE 3001

# Start application
CMD ["node", "server.js"]