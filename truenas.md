
https://tomschlick.com/blog/2022/06/28/extend-truenas-web-ui-session-timeout/

sed -i 's/auth.generate_token",\[300/auth.generate_token",\[129600/g'  /usr/share/truenas/webui/*.js

sed -i 's/auth.generate_token",\[300/auth.generate_token",\[3600/g' /usr/share/truenas/webui/*.js

