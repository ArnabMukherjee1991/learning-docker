#import a remote base image
FROM node:alpine as builder
#define a folder in the container to start the application
WORKDIR '/app'
#copy specific file needed to run npm install
#COPY package.json .
#Build image with npm install

RUN npm install yarn
COPY package.json .

RUN yarn cache clean
RUN yarn install

COPY . .
#Try to create an user who has access to /app directory
#RUN useradd -ms /bin/bash admin
#RUN chown -R admin:admin /app
#USER admin

RUN yarn build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html