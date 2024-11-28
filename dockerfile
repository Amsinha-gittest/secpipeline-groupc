# Stage 1: Build the Go application
FROM golang:1.23 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY . .

# Download the Go dependencies (if any) and build the application
RUN go mod tidy
RUN go build -o main .

# Stage 2: Build the runtime image
FROM alpine:3.17

# Install necessary dependencies (e.g., CA certificates)
RUN apk --no-cache add ca-certificates

# Set the working directory inside the container
WORKDIR /root/

# Copy the compiled Go binary from the builder image
COPY --from=builder /app/main .

# Expose port 80
EXPOSE 80

# Command to run the Go application
CMD ["./main"]