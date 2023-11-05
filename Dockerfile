# stage 1
FROM node:16 AS builder
WORKDIR /app
COPY . .
RUN npm install --force
# Copy your entire Angular project to the container
# Build the Angular app
RUN npm run build --prod
# Stage 2: Create a lightweight image for serving the Angular app
FROM nginx:1.25.2-alpine

# Copy the built Angular app from the build stage to Nginx HTML directory
COPY --from=builder /app/dist/summer-workshop-angular  /usr/share/nginx/html
