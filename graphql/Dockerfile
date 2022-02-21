FROM 984392288310.dkr.ecr.us-east-1.amazonaws.com/node:14-alpine

WORKDIR /var/www

COPY ./graphql/package.json ./graphql/package-lock.json ./

RUN npm ci

COPY ./graphql/ /var/www/
COPY ./proto/ /var/proto/

CMD ["npm", "start"]
