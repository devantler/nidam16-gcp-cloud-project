FROM node:current-alpine as develop-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM develop-stage as build-stage

RUN npm run build

FROM nginx:alpine as production-stage

ENV NODE_ENV=production REGION=asia-east1

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["sh", "-c", "cd /usr/share/nginx/html/ && ./set-env.sh && nginx -g 'daemon off;'"]
