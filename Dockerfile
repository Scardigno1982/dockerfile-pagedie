# Utilizamos una versión específica de Node. Puedes cambiarla por la que necesites.
FROM node:14

# Configuramos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Clonar el repositorio privado usando SSH
RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    git clone git@github.com:jsm-l/pldatos.git .

# Instalar dependencias del proyecto Angular
RUN npm install

# Construir el proyecto para producción
RUN npm run build -- --output-path=./dist/out

# Instalar un servidor web, por ejemplo, `http-server` para servir el contenido estático
RUN npm install -g http-server

# Exponemos el puerto que usará el servidor web
EXPOSE 8080

# Iniciar el servidor web y servir la aplicación construida
CMD [ "http-server", "dist/out", "-p 8080" ]
