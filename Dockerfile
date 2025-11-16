# Stage 1: Dependencies
FROM oven/bun:1-alpine AS deps

WORKDIR /app

# Copy only package files for better caching
COPY package.json bun.lockb* ./

# Install only production dependencies
RUN bun install --frozen-lockfile --production

# Stage 2: Build
FROM oven/bun:1-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json bun.lockb* ./

# Install all dependencies (including dev)
RUN bun install --frozen-lockfile

# Copy source code
COPY . .

# Build the static site
RUN bun run build

# Stage 3: Production
FROM nginx:alpine-slim AS runtime

# Remove default nginx config and files
RUN rm -rf /usr/share/nginx/html/* \
    && rm -f /etc/nginx/nginx.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy only built static files from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Set proper permissions for nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx (runs as root but workers run as nginx user)
CMD ["nginx", "-g", "daemon off;"]
