FROM tiangolo/node-frontend:16 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install --legacy-peer-deps
COPY ./ /app/
ARG CONFIGURATION=production-mx
RUN npm run build --prod  -- --output-path=./dist/out
FROM  nginx:1.22.1
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html
