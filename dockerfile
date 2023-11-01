FROM node:16 as build
WORKDIR /usr/src/app
COPY package*.json .
COPY . .
RUN npm install
RUN npm run  build 
#Production stage
FROM nginx:alpine
# Copier les fichiers de build de l'application Angular dans le répertoire NGINX
#COPY --from=build /usr/src/app/build /usr/share/nginx/html/
COPY --from=build /usr/src /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80
# Commande pour démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]