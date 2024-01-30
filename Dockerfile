# Use the official Golang image
FROM amd64/golang:1.20.5-bullseye

# Install ODBC packages
RUN apt-get update && \
    apt-get install -y unixodbc=2.3.6-0.1+b1 && \
    apt-get install -y unixodbc-dev=2.3.6-0.1+b1 && \
    apt-get install -y dpkg-dev


# Set the working directory in the container
WORKDIR /app

COPY . .
COPY ./obdc.ini /usr/local/etc/odbc.ini

ENV ODBCINI=/usr/local/etc/odbc.ini
ENV ODBCSYSINI=/usr/local/etc

RUN dpkg -i /app/mysql-community-client-plugins_8.3.0-1debian11_amd64.deb
RUN dpkg -i /app/mysql-connector-odbc_8.3.0-1debian11_amd64.deb

# Go Build
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
