# Start from an official Node.js image.
FROM node:22-alpine

# Set the working directory inside the image.
WORKDIR /app

# Copy dependency manifests first to make Docker layer caching more efficient.
COPY package*.json ./

# Install only production dependencies.
RUN npm install --omit=dev

# Copy the application source code.
COPY . .

# The application listens on port 3000.
EXPOSE 3000

# Start the Node.js application.
CMD ["npm", "start"]
