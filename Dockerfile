# NOFX has no releases: pin both images to one upstream commit (sha-<commit>-amd64).
FROM ghcr.io/nofxaios/nofx/nofx-frontend:sha-4a5e9ac-amd64 AS frontend
FROM ghcr.io/nofxaios/nofx/nofx-backend:sha-4a5e9ac-amd64
RUN apk add --no-cache nginx openssl
COPY --from=frontend /usr/share/nginx/html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/http.d/default.conf
COPY railway-start /railway-start
ENV DB_PATH=/app/data/data.db
EXPOSE 8080
CMD ["/railway-start"]
