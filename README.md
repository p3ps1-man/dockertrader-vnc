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

3. Create encrypted password so it can be later mounted as vnc password to your directory (you can use this image to generate it)
```bash
docker run --rm -v ./pass:/home/mt5/password dockertrader-vnc x11vnc -storepasswd changeme password/passwd
```

4. Mount your generated password and you are ready to go
```bash
docker run -v ./pass:/home/mt5/password -p 3000:3000 dockertrader-vnc
```
Or you can use docker-compose
```bash
services:
  metatrader:
    image: dockertrader-vnc
    container_name: mt5
    ports:
      - "3000:3000"
    volumes:
      - app:/home/mt5/program/
      - ./pass/:/home/mt5/password

volumes:
  app:
```
You will get browser ssl security warning because its a self signed ssl certificate but you can mount your own generated with letsencrypt - it will be explained in mounts section.

5. Acess it via link in your browser [https://localhost:3000/vnc.html](https://localhost:3000/vnc.html)

## Mounts and notices

There are several key mounts:

1. ```/home/mt5/password``` mount this directory with your generated password filename should be ```passwd``` for accessing vnc
2. ```/home/mt5/ssl``` this directory is used for key.pem and cert.pem so you can forward it from your host to skip browser warning
3. ```/home/mt5/program/MQL5/Experts``` this is expert directory you can bundle all your experts or just one

Log files are located in ```/home/mt5/.supervisor``` directory.

Default user is mt5 and installation path is program directory inside its home directory ```/home/mt5/program```. Permissions are preconfigured for mt5 user with GID:1000 and UID:1000.


