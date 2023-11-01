# Étape de construction
FROM node:16 as build
WORKDIR /usr/src/app
COPY package*.json .
COPY . .
RUN npm install
RUN npm run  build 

# Étape de production
FROM nginx:alpine
# Copier les fichiers de build générés à partir de l'emplacement "dist/summer-workshop-angular"
COPY --from=build /usr/src/app/dist/summer-workshop-angular /usr/share/nginx/html
# Exposer le port 80
EXPOSE 80
# Commande pour démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]