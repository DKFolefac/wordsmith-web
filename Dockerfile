FROM golang:1.23-alpine AS builder

WORKDIR /myapp  # Adjust path based on your Go project structure
COPY . .
RUN go mod download
RUN go build -o my-app ./myapp

FROM alpine:latest
COPY --from=builder /go/bin/my-app /app/myapp
WORKDIR /app

ENV WEB_APP_PORT=80 
# Optional: Listening port
EXPOSE $WEB_APP_PORT

# Configure database connection (replace with your approach)
ENV DB_HOST=postgres  
# Assuming PostgreSQL container name is "postgres"
ENV DB_PORT=5432
ENV DB_USER=userw
ENV DB_PASSWORD=passwordw
ENV DB_NAME=databasew

# Entrypoint (replace with your logic)
ENTRYPOINT ["/app/myapp", "-http", ":$WEB_APP_PORT"]