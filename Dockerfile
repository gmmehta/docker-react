#
# multi stage docker file
#
# phase 1 - the build phase
#

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#
# output of the above will be
# /app/build <-- all the stuff we care about is in this folder
#

# phase 2 - the run phase

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

