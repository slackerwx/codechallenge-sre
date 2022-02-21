FROM node:14-alpine as builder

WORKDIR /app

COPY ./client/package.json ./client/package-lock.json ./

RUN npm install

COPY ./client/ ./

RUN npm run build

FROM 984392288310.dkr.ecr.us-east-1.amazonaws.com/nginx:1.21.4-alpine

COPY --from=builder /app/build/ /usr/share/nginx/html
