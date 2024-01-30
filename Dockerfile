# Use the official Golang image
FROM golang:1.21.6-bullseye

# Set the working directory in the container
WORKDIR /app


COPY . .

# Download go pkg
RUN go mod vendor

# Build the Go app
RUN go build -o myapp .

# Make the wait-for script executable
RUN chmod +x ./wait-for.sh

# Expose port 8080 to the outside world
EXPOSE 3000

# Command to run the executable
# CMD ["./myapp"]
CMD ["./wait-for.sh", "mysql:3306", "--", "./myapp"]
