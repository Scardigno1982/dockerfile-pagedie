# Utilizamos una versión específica de Node. Puedes cambiarla por la que necesites.
FROM node:14

# Configuramos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Argumento que será el Personal Access Token
ARG GITHUB_PAT

# Configurar Git para que use el token como contraseña.
RUN git config --global credential.helper 'cache --timeout=3600'
RUN git config --global credential.username Scardigno1982
# Clonar el código del repositorio GitHub utilizando el token como contraseña
RUN echo "machine github.com login Scardigno1982 password $GITHUB_PAT" > ~/.netrc

# Clonar el repositorio privado
RUN git clone https://Scardigno1982:${GITHUB_PAT}@github.com/jsm-l/pldatos.git .

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
