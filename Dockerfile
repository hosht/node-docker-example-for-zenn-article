# syntax=docker/dockerfile:1.20.0
FROM node:24.11.1-bookworm-slim AS builder
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable pnpm
WORKDIR /app
COPY pnpm-lock.yaml /app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm fetch
COPY . /app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --offline
RUN pnpm run build
RUN pnpm prune --prod --ignore-scripts

FROM gcr.io/distroless/nodejs24-debian12:nonroot AS app
ENV NODE_ENV=production
WORKDIR /app
COPY --from=builder --chown=nonroot:nonroot /app/dist /app/dist
COPY --from=builder --chown=nonroot:nonroot /app/node_modules /app/node_modules
COPY --from=builder --chown=nonroot:nonroot /app/package.json /app/package.json
ENV NODE_OPTIONS="--enable-source-maps"
CMD ["dist/index.js"]
