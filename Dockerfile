# Use an official Node.js runtime as the base image for build stage
FROM node:latest AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Angular app in production mode
RUN npm run build --prod

# Use a lightweight Node.js image for the final image
FROM node:alpine

# Install http-server to serve Angular app
RUN npm install -g http-server

# Set the working directory in the container
WORKDIR /app

# Copy the built Angular app from the build stage to the final image
COPY --from=build /app/dist/my-angular-app .

# Expose the port the app runs on
EXPOSE 8080

# Command to serve Angular app using http-server
CMD ["http-server", "-p", "8080"]
