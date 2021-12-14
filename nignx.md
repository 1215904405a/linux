user  root staff;
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;
        server_name front.qdingnet.com devfront.qdingnet.com qafront.qdingnet.com;
        #access_log    /var/log/nginx/access.log;
        #error_log     /var/log/nginx/error.log;
        autoindex on;
        add_header Access-Control-Allow-Origin 'qdingnet.com';
        location /polymer/ {
             ## 启动 Content-Encoding: gzip  
             gzip on; 
             gzip_buffers 32 4K;
             gzip_comp_level 6;
             gzip_min_length 100;
             gzip_types application/javascript text/css text/xml;
             gzip_disable "MSIE [1-6]\.";
             gzip_vary on;
             alias /Users/yong/qd/front/polymer/;
             index index.client.html index.html;
        }
        location /saas-web/ {
             alias /Users/yong/qd/saas/;
        }
        location / {
            rewrite ^/([\w-]+)/(.*)$ /$1/temp/$2 break;
            root /Users/yong/qd/front/;
        }
    }

    server {
      listen  80;
      server_name  m2.iqdnet.com qam.iqdnet.com devm.iqdnet.com;
      access_log /data/logs/devm-access.log;
      error_log /data/logs/devm-error.log;
      add_header Access-Control-Allow-origin *;
      add_header Access-Control-Allow-Methods 'GET, POST';
      location / {
        proxy_pass http://127.0.0.1:9000;
      }
    }


    server {
      listen  80;
      server_name  qatm.iqdnet.com;

      location / {
        proxy_pass http://127.0.0.1:9001;
      }
    }

    server {
      listen  80;
      server_name  qafm.iqdnet.com;

      location / {
        proxy_pass http://127.0.0.1:9002;
      }
    }

    server {
      listen  80;
      server_name  devb.qdingnet.com;
      access_log    /var/log/nginx/access.log;
      error_log     /var/log/nginx/error.log;
      location / {
        proxy_pass http://127.0.0.1:9003;
      }
    }

    server {
      listen  80;
      server_name  bigdata.qdingnet.com;

      location / {
        proxy_pass http://127.0.0.1:3000;
      }
    }
}
