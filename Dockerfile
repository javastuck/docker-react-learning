FROM node:alpine as builder
#everything below the first line is seen as the builder phase
WORKDIR /app
COPY package.json .
RUN npm install
# we don't need to worry about volumes since the code isnt changing
COPY . .
RUN npm run build

# /app/build <-- contains results of npm run build step
# specifying a second base image indicates the end of the
# previous build step and the beginning of the next step
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# default command of nginx container starts up nginx
# so we don't need to add anything here