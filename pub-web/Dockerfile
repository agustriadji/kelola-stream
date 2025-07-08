# Builder
FROM node:18-slim AS base
# Enable dependency caching
RUN corepack enable
# Set working directory
WORKDIR /app
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY . .

# runtime dev
FROM base AS dev
COPY --from=base /app/public public
COPY --from=base /app/src src
COPY --from=base /app/package.json .
EXPOSE 3000
CMD ["npm","run","dev"]

# runtime stg
FROM base AS stg
COPY --from=base /app/public public
COPY --from=base /app/package.json .
RUN npm ci && npm run build
COPY --from=base /app/.next .next
EXPOSE 3001
CMD ["npm","run","start"]

# runtime prod
FROM base AS prod
COPY --from=base /app/public public
COPY --from=base /app/package.json ./
COPY --from=base /app/.next .next
RUN npm ci --omit=dev && npm run build
EXPOSE 3002
CMD ["npm","run","start"]