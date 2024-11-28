# Build stage
FROM golang:1.20-alpine AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY . .

# Install dependencies (if any)
RUN go mod tidy

# Build the Go app
RUN go build -o main .

# Final stage (use a smaller base image for the final container)
FROM alpine:latest

# Set the working directory in the final image
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/main .

# Expose port 80 to be accessible outside the container
EXPOSE 80

# Command to run the executable
CMD ["./main"]
