FROM golang:alpine as builder

WORKDIR /usr/local/app
ARG TARGETARCH
 # Adjust path based on your Go project structure
COPY dispatcher.go .

RUN GOOS=linux GOARCH=$TARGETARCH go build dispatcher.go 

FROM alpine:latest
WORKDIR /usr/local/app
COPY --from=builder /usr/local/app/dispatcher ./
COPY static ./static/ 

# Optional: Listening port
EXPOSE 80

# Configure database connection (replace with your approach)
ENV DB_HOST=postgres  
# Assuming PostgreSQL container name is "postgres"
ENV DB_PORT=5432
ENV DB_USER=userw
ENV DB_PASSWORD=passwordw
ENV DB_NAME=databasew

# Entrypoint (replace with your logic)
CMD ["/usr/local/app/dispatcher"]