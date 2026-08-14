########################################
# Stage 1: Build
########################################

ARG NODE_VERSION=22-alpine

FROM node:${NODE_VERSION} AS build

# Telemetrie im CI/Container deaktivieren
ENV NEXT_TELEMETRY_DISABLED=1

# Set working directory
WORKDIR /app

# Copy Application Code
COPY . .

# Dependencies installieren
RUN npm install

# Next.js inlined NEXT_PUBLIC_* Variablen zur Build-Zeit fest ins Client-Bundle,
# daher muss die Backend-URL bereits hier bekannt sein. Der Wert wird nicht
# hardcodiert, sondern aus docker-compose.yml als Build-Arg uebergeben.
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

# Erzeugt standalone version in  .next/standalone
RUN npm run build


########################################
# Stage 2: Runtime
########################################
FROM node:${NODE_VERSION} AS runtime

WORKDIR /app

# Set production environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Telemetrie im CI/Container deaktivieren
ENV NEXT_TELEMETRY_DISABLED=1


# Nur die Build-Artefakte ins Runtime-Image - keine Quellen,
# keine Dev-Dependencies.
# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=build --chown=node:node /app/.next/standalone ./
COPY --from=build --chown=node:node /app/.next/static ./.next/static
COPY --from=build --chown=node:node /app/public ./public

# Switch to non-root user for security best practices
USER node

# Expose port 3000 to allow HTTP traffic
EXPOSE 3000

CMD ["node", "server.js"]
