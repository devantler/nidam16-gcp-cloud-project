FROM node:current-alpine as develop-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM develop-stage as build-stage

RUN npm run build

FROM nginx:alpine as production-stage

ENV NODE_ENV production

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
