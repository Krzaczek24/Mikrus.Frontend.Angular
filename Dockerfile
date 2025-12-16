# =========================================
# Stage 1: Build the Angular Application
# =========================================
ARG NODE_VERSION=24.12.0-alpine
ARG NGINX_VERSION=alpine3.22

#FROM node:${NODE_VERSION} AS builder
#WORKDIR /app
#COPY package.json package-lock.json ./
#RUN --mount=type=cache,target=/root/.npm npm ci --prefer-offline
#COPY . .
#RUN npm run build --omit=dev --verbose

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner
USER nginx
COPY nginx.conf /etc/nginx/nginx.conf
#COPY --chown=nginx:nginx --from=builder /app/dist/*/browser /usr/share/nginx/html
COPY --chown=nginx:nginx /dist/mikrus.frontend/browser /usr/share/nginx/html
EXPOSE 8080
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]