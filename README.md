# Metatrader 5 vnc docker image [![](https://img.shields.io/docker/pulls/p3ps1man/dockertrader-vnc)](https://hub.docker.com/r/p3ps1man/dockertrader-vnc)

This image lets you run headless Metratrader 5 terminal via websockify vnc. You can access the terminal via web browser for login, configurations etc. Switch to local scaling for a better preview. If you need to restart the terminal just close it it will restart automaticly.

![](/screenshots/program.png)

## Features

- Run headless Metratrader 5 terminal
- Access the terminal via web browser

## Requirements

- Docker installed on your machine.
- x86_64 cpu

## Usage

1. Clone repository:
```bash
git clone https://github.com/p3ps1-man/dockertrader-vnc
cd ockertrader-vnc
```

2. Build the Docker image:
```bash
docker build -t image_name .
```
Or just pull it from dockerhub:
```bash
docker pull p3ps1man/dockertrader-vnc
```

3. Run the container, pass the password as ENV var container and access it [https://localhost:3000/vnc.html](https://localhost:3000/vnc.html) 
```bash
docker run -e VNC_PASSWORD=123 -p 3000:3000 p3ps1man/dockertrader-vnc
```
Or you can use docker-compose
```bash
services:
  metatrader:
    image: p3ps1man/dockertrader-vnc
    container_name: mt5
    environment:
      - VNC_PASSWORD=123 
    ports:
      - "3000:3000"
    volumes:
      - app:/home/mt5/program/
volumes:
  app:
```
You will get browser ssl security warning because its a self signed ssl certificate but you can mount your own generated with letsencrypt - it will be explained in mounts section.

## Mounts and notices

There two key mounts:

1. ```/home/mt5/ssl``` this directory is used for key.pem and cert.pem so you can forward it from your host to skip browser warning
2. ```/home/mt5/program/MQL5/Experts``` this is expert directory you can bundle all your experts or just one

Log files are located in ```/home/mt5/.supervisor``` directory.

Default user is mt5 and installation path is program directory inside its home directory ```/home/mt5/program```. Permissions are preconfigured for mt5 user with GID:1000 and UID:1000.


