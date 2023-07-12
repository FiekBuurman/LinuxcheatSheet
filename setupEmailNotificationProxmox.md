resource https://technotim.live/posts/proxmox-alerts/

# install dependencies:
```
apt update
apt install -y libsasl2-modules mailutils 
```

# setup gmail
Create app password in google/gmail
 - https://myaccount.google.com/apppasswords

# Configure postfix
 - echo "smtp.gmail.com your-email@gmail.com:YourAppPassword" > /etc/postfix/sasl_passwd
Check the file:  
 - ls -l /etc/postfix/sasl_passwd

 Set permissions
  - chmod 600 /etc/postfix/sasl_passwd
 hash the file
  - postmap hash:/etc/postfix/sasl_passwd
check to to be sure the db file was create
 - cat /etc/postfix/sasl_passwd.db
edit postfix config
 - nano /etc/postfix/main.cf
add
 ```
 # google mail configuration
relayhost = smtp.gmail.com:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/Entrust_Root_Certification_Authority.pem
smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
smtp_tls_session_cache_timeout = 3600s
 ```
reload service
 - postfix reload

# send test mail
```
echo "This is a test message sent from postfix on my Proxmox Server" | mail -s "Test Email from Proxmox" fiekbuurman@gmail.com
```

# fix from name in email
install dependency
 - apt update && apt install postfix-pcre
edit config
 - nano /etc/postfix/smtp_header_checks
put in
 - /^From:.*/ REPLACE From: Buurmans Proxmox Tower <pve1-alert@something.com>
add to config
 - nano /etc/postfix/main.cf
add to the bottom:
 - smtp_header_checks = pcre:/etc/postfix/smtp_header_checks
hash the file:
 - postmap hash:/etc/postfix/smtp_header_checks
reload service
 - postfix reload
send test email

- setup backup email
check if this line in not commented: ZED_EMAIL_ADDR="root"
- nano /etc/zfs/zed.d/zed.rc