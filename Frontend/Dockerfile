FROM node:current-alpine as develop-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM develop-stage as build-stage

RUN npm run build

FROM nginx:alpine as production-stage

ENV NODE_ENV=production, REACT_APP_REGION=asia-east1

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD sh -c "envsubst '$NODE_ENV $REACT_APP_REGION' < /etc/nginx/conf.d/site.template > /etc/nginx/conf.d/site.conf && exec nginx -g 'daemon off;'"
