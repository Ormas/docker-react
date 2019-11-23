#Ge den namnet builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

#Run  phase där vi installerar nginx och kopierar över reslutatet från builder
FROM nginx
#Behövs för AWS
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#nginx startas upp automatiskt så vi behöver inte göra något