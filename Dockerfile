# Use a base image with bash and nc installed
FROM alpine:latest

# Install netcat (nc) and bash
RUN apk add --no-cache bash netcat-openbsd

# Copy the echo server script into the container
COPY echo_server.sh /usr/local/bin/echo_server.sh

# Make the script executable
RUN chmod +x /usr/local/bin/echo_server.sh

# Expose the port
EXPOSE 8080

# Define the default command
CMD ["/usr/local/bin/echo_server.sh"]
