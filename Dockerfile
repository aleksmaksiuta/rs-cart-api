FROM node:12.22-alpine AS base
WORKDIR /app

FROM base AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM dependencies AS build
WORKDIR /app
COPY . .
RUN npm run build

FROM base AS release
WORKDIR /app
COPY --from=dependencies /app/package*.json ./
RUN npm install --only=production
COPY --from=build /app/dist ./dist
COPY --from=build /app/Dockerfile ./

ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
