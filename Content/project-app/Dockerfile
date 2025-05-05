# syntax=docker/dockerfile:1
ARG NODE_VERSION=22.13.1

# Builder stage
FROM node:${NODE_VERSION}-slim AS builder
WORKDIR /app

# Install dependencies with cache and bind mounts for deterministic builds
COPY --link package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    npm ci --production

# Copy application source
COPY --link . .

# Run depcheck to ensure no unused dependencies
RUN npx depcheck

# Final production image
FROM node:${NODE_VERSION}-alpine AS final
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S -G appgroup appuser

# Copy only necessary files from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/index.js ./

ENV NODE_ENV=production
EXPOSE 3000
USER appuser

CMD ["npm", "start"]