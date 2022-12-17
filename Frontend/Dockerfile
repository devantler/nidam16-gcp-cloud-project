FROM node:current-alpine as develop-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM develop-stage as build-stage

RUN npm run build

FROM nginx:alpine as production-stage

ENV NODE_ENV=production, REGION=asia-east1

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

EXPOSE 8080

CMD sh -c "envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
