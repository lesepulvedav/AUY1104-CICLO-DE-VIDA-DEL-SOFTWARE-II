FROM node:20-slim AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --only=production

COPY index2525.js ./

FROM node:20-slim AS production

ARG BUILD_COLOR="Blue"
ENV NODE_ENV production

ENV APP_COLOR $BUILD_COLOR 

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/index.js ./

EXPOSE 3000

CMD ["node", "index.js"]
