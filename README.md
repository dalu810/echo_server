## Echo Server

A multi-component project featuring an HTTP echo server, Docker containerization, and AWS deployment with Terraform.

## Components

1. **HTTP Echo Server** (`echo_server.sh`)
2. **Docker Container** (`Dockerfile`)
3. **Multi-Server Deployment** (`docker-compose.yml` + Nginx config)
4. **AWS Infrastructure** (Terraform)

## Prerequisites

- Linux environment
- Docker and Docker Compose
- Terraform (for AWS deployment)
- Ncat (`nc`) and curl (for testing)

## 1. Basic Echo Server

### Usage

Run server (default port 8080, default message)

```
./echo_server.sh &
```

Run with custom port and message

```
./echo_server.sh 8080 "Custom Message" &
```

Test with curl

```
curl http://localhost:8080
```

## 2. Docker Container

### Build and Run

```
docker build -t echo-server .
docker run -d -p 8080:8080 -e MESSAGE="Hello from container" echo-server
```

## 3. Multi-Server Deployment with Nginx

### Configuration

Two echo servers (echo-server-a and echo-server-b)
Nginx reverse proxy with path-based routing

### Start System

```
docker-compose up -d --build
```

### Test Endpoints

```
curl http://localhost:8080 # -> echo-server-a
curl http://localhost:8080/a # -> echo-server-a
curl http://localhost:8080/b # -> echo-server-b
curl http://localhost:8081 # direct access to echo-server-a
curl http://localhost:8082 # direct access to echo-server-b
```

## 4. AWS Deployment with Terraform

### Requirements

- AWS account with credentials configured
- Terraform installed
- Existing EC2 key pair

### Deployment

Initialize Terraform:

```
terraform init
terraform apply
```

Access the server:

```
curl http://<EC2_PUBLIC_IP>:8080
```

**Configuration Details**
Security group allows SSH (port 22) and HTTP (ports 80, 8080) from your IP
Automatically installs Docker and runs the echo server container

### Project Structure

```
📁echo_server
├── echo_server.sh # Bash echo server implementation
├── Dockerfile # Docker container definition
├── docker-compose.yml # Multi-service deployment
├── default.conf # Nginx configuration
├── main.tf # Terraform AWS configuration
└── README.md # This file
```

## License

MIT License

You may want to:

- Add a `LICENSE` file
- Include screenshots of successful test results
- Add a CI/CD section if you implement automated testing/deployment
- Include troubleshooting tips for common issues
