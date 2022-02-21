FROM 984392288310.dkr.ecr.us-east-1.amazonaws.com/node:14-alpine

WORKDIR /var/www

RUN apk add --no-cache --virtual python make g++

RUN apk add --no-cache --virtual .gyp

COPY ./auth/package.json ./auth/package-lock.json ./

RUN npm ci

RUN apk del .gyp

COPY ./auth /var/www/

CMD ["npm", "start"]
