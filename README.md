# Nginx (Hello & Welcome Demo)

## What is Nginx?

[Nginx](https://www.nginx.com/) (pronounced "Engine X") is a high-performance web server and reverse proxy server. It is widely used to serve static files, handle load balancing, and manage HTTP traffic efficiently. Nginx is lightweight, fast, and highly configurable, making it one of the most popular web servers in the world.

## Why this Project?

The goal of this project is to **learn and practice serving static web pages using Nginx on a Windows setup** without writing any backend API.  

By doing this project, we learned:

* How to install and run Nginx on Windows.  
* How to configure `nginx.conf` to serve custom HTML pages.  
* How to create simple endpoints (`/hello` and `/welcome`) using only Nginx configuration.  
* How to debug Nginx errors and fix configuration issues like duplicate `server_name`.  

This project is **purely educational**, focusing on understanding the basic Nginx workflow and static file serving.

---

## Project Structure

nginx-1.28.0/

├─ conf/ # Nginx configuration files

│ └─ nginx.conf # Main configuration with server block

├─ myapp/ # HTML pages

│ ├─ hello.html

│ └─ welcome.html

├─ Dockerfile            

└─ docker-compose.yml 


## Steps to Run the Project

### 1. Download Nginx
Download the **Windows version of Nginx** from [nginx.org](https://nginx.org/en/download.html) and place it in your project folder.
 ---
 
### 2. Add HTML Pages
Create a folder `myapp/` and add two simple HTML files:
* `hello.html`  

  ```
  Hello
  ```
* `welcome.html`

    ```
    Welcome
    ```
---

### 3. Configure Nginx
Update `conf/nginx.conf` with the following `server` block inside `http` block:
```
# Redirect HTTP to HTTPS
server {
    listen 80;   #server returns 301 to HTTPS — forces secure access.
    server_name localhost;
    return 301 https://$host$request_uri;
}

# HTTPS server
server {
    listen 443 ssl;   # tells nginx to accept TLS on port 443 inside the container
    server_name localhost;

    ssl_certificate     /etc/nginx/ssl/fullchain.crt;    # ssl_certificate / ssl_certificate_key — file paths to cert and key inside container (we'll mount ssl/ to /etc/nginx/ssl).
    ssl_certificate_key /etc/nginx/ssl/privkey.key;

    ssl_protocols TLSv1.2 TLSv1.3;    # basic TLS config (good defaults for dev).
    ssl_ciphers   HIGH:!aNULL:!MD5;

    location = /hello {
        alias /usr/share/nginx/html/hello.html;
        default_type text/plain;
    }

    location = /welcome {
        alias /usr/share/nginx/html/welcome.html;
        default_type text/plain;
    }

    location = / {
        return 200 "Nginx (HTTPS) is running. Use /hello or /welcome";
        default_type text/plain;
    }
}

```
**Note**: Replace `C:/path/to/myapp/` with your actual absolute path to the myapp folder.



### 4.Test Nginx Configuration
Open **VS Code terminal** in the Nginx folder and run:
```
.\nginx.exe -t

```
You should see:
```
syntax is ok
configuration test is successful

```

### 5. Start Nginx
```
.\nginx.exe

```
Check if the process started:
```
Get-Process -Name nginx

```

### 6. Access the Pages
Open your browser and visit:
```
http://localhost/
http://localhost/hello
http://localhost/welcome
```
You should see:

* `/hello` → Hello

* `/welcome` → Welcome

* `/` → Nginx is running. Use /hello or /welcome


### 7. Debugging Tips
* If you see errors like `conflicting server name "localhost"` → stop extra nginx processes.

* Use `.\nginx.exe -s` reload after config changes.

* Check logs: `logs/error.log` for detailed error messages. 

---

## Build & Run (with one command)
```
docker-compose up --build -d

```

**Author**: Divyansh Sharma 

**Date**: October 2025
