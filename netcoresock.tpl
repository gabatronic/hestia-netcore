server {
        listen %ip%:%proxy_port%;
        server_name %domain_idn% %alias_idn%;
        error_log /var/log/%web_system%/domains/%domain%.error.log error;

        location / {
            proxy_pass         http://unix:%home%/%user%/web/%domain%/netcoreapp/app.sock;
            proxy_http_version 1.1;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Connection keep-alive;
            proxy_set_header   Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
        }
        location /error/ {
                 alias %home%/%user%/web/%domain%/document_errors/;
        }

        location @fallback {
                 proxy_pass http://unix:%home%/%user%/web/%domain%/netcoreapp/app.sock;
        }

        location ~ /\.ht {return 404;}
        location ~ /\.svn/ {return 404;}
        location ~ /\.git/ {return 404;}
        location ~ /\.hg/ {return 404;}
        location ~ /\.bzr/ {return 404;}
        include %home%/%user%/conf/web/nginx.%domain%.conf*;
}
