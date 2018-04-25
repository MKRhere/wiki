# nginx hacks and snippets

## Remove .html and rewrite urls

```text
server {
		listen 80;
		listen [::]:80;
		root <root_dir>;
		index index.html index.htm;

		server_name <server_name>;

		# rewrites .html to pretty urls
		rewrite ^(/.+)\.html$ $scheme://$host$1 permanent;

		location / {
				index index.html index.htm;
				try_files $uri.html $uri $uri/ @handler;
		}
}
```