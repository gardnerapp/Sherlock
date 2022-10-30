# Sherlock
A Digital Forensics Tool Written With Ruby

## Sherlock Works By Customizing Your Nginx logs to provide JSON output

### An example configuration found in `/etc/nginx/nginx.conf/`:
  `access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        log_format custom '{"remote_addr": "$remote_addr", "remote_user": "$remote_user", "time_local": "$time_local", "request": "$request","status": "$status", "body_bytes_sent": "$body_bytes_sent", "http_referer": "$http_referer", "http_user_agent": "$http_user_agent"},' `

You can Learn More About Customizing Nginx Here -> https://docs.nginx.com/nginx/admin-guide/monitoring/logging/

## Usage & Supported Modes:


## TODO
### Super Cool Logo
### Software Licensing
### Usage
### Contributing Guidelines
### Switch From Opts to Thor
### Add Processing module
### Add functional test w rspec
### Add cucumber and aruba to test cli interface
