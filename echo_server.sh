#!/bin/bash

PORT=${PORT:-8080}
MESSAGE=${MESSAGE:-"Hello from echo server"}

echo "Echo server is running on port:$PORT with response message:$MESSAGE"

# Define a trap to cleanly exit when the script is killed
trap "echo 'Terminating the server...'; exit 0" SIGINT SIGTERM

# Infinite loop to keep the server running and handle multiple requests
while true; do
  # Handle each connection and send a response, close connection after responding
  echo -ne "HTTP/1.1 200 OK\r\nContent-Length: ${#MESSAGE}\r\nContent-Type: text/plain\r\n\r\n$MESSAGE" | nc -l $PORT
done
