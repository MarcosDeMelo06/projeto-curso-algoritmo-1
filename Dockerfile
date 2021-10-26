# The builder from node image
FROM node:latest as builder
# Move our files into directory name "app"
WORKDIR /usr/src/app
RUN npm install @angular/cli -g
COPY package*.json ./
RUN npm install
COPY .  .
# Build
RUN npm run build
###################################################

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/dist/intercom-challenge-front/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
