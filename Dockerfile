# --- Stage 1: Build the React app ---
FROM node:14-alpine AS builder

# Install git to enable pulling https://github.com/alex-bogl/terminal-in-react-bogl.git during npm install
RUN apk add --no-cache git

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# --- Stage 2: Serve with Nginx ---
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
