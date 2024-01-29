# Stage 1: Build Angular app
FROM node:16 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

# Stage 2: Serve Angular app with Nginx
FROM nginx:alpine

COPY --from=builder /app/dist/* /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
