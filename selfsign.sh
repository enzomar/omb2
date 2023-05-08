echo "create a self-signed key and certificate pair"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout revproxy/conf/nginx/ssl/private/nginx-selfsigned.key -out revproxy/conf/nginx/ssl/certs/nginx-selfsigned.crt -subj "/C=US/CN=FlexOffice-Root-CA"

# echo "create strong Diffie-Hellman (DH) group. It can take some time 10min -> 1h"
# openssl dhparam -out revproxy/conf/nginx/dhparam.pem 4096
