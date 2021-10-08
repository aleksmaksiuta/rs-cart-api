FROM node:12.22.6-alpine3.14
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
