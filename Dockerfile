# Node.js
FROM node:18.20.4-alpine3.20
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

#RUN mkdir -p /app/public && \
#    mkdir -p /app/public/css && \
#    mkdir -p /app/public/js && \
#    cp -r public/css/* /app/public/css/ && \
#    cp -r public/js/* /app/public/js/

EXPOSE 3000

CMD ["node", "app.js"]

