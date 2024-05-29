# Step 1: Build the React application
FROM node:20.13.1-alpine as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./

RUN npm install

# Copy local code to the container image
COPY . ./

# Build the React app
RUN npm run build

### STAGE 2: Run ###
FROM nginx:latest

COPY --from=build /app/dist /usr/share/nginx/html/

# Add your custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the NGINX server
#EXPOSE 80

# Start NGINX when the container launches
CMD ["nginx", "-g", "daemon off;"]