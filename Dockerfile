# Node.js
FROM node:18.20.4-alpine3.20 AS build
WORKDIR /parking-front

COPY package*.json .
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "public/app.js"]

## Nginx
#FROM nginx:alpine
#
#RUN apk --update add nginx && \
#        rm -rf /var/cache/apk/*
#
#COPY default.conf /etc/nginx/conf.d/default.conf
#
#COPY --from=build /parking-front/public /usr/share/nginx/html/public
#
#EXPOSE 80
#
#CMD ["nginx", "-g", "daemon off;"]