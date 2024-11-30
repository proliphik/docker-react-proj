# # stage 1: build stage
# # without multistage, this is what i see
# # root@2e4d62222601:/app# ls
# # Dockerfile.dev	README.md  build  docker-compose.yml  node_modules  package-lock.json  package.json  public  src
# FROM nginx:1.26.2

# RUN apt-get update
# RUN apt-get install -y npm

# WORKDIR /app

# COPY package.json .

# RUN npm install

# COPY . .

# RUN npm run build

# # stage 2: run stage

# RUN mv /app/build/* /usr/share/nginx/html/



# before multi stage build:
    # nginx-react                                                    latest           7d1a41851b4c   35 seconds ago   730MB
# after multi stage build
    # nginx-react                                                    latest           57cb3ad8af0f   3 seconds ago   188MB
# after using nginx alpine
    # nginx-react                                                    latest           aedcd0b7a615   14 seconds ago   49.3MB



FROM node:20-alpine

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.26.2-alpine

COPY --from=0 /app/build/* /usr/share/nginx/html/