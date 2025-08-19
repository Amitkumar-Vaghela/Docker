FROM ubuntu:latest

# Install curl and prerequisites
RUN apt-get update && apt-get install -y curl

# Add Node.js 18.x repo and install Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Upgrade system (optional, can be skipped to make build faster)
RUN apt-get upgrade -y

# Set work directory inside container
WORKDIR /app

# Copy package files first (for caching npm install)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY main.js .

# Expose port 3000
EXPOSE 3000

# Run the app
ENTRYPOINT ["node", "main.js"]
