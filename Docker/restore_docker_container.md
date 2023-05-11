Restore data or grab latest from devops host /backups/
Create new CT in proxmox from the template and make sure docker is installed.
Copy data over, like for Heimdall is was:
```
scp -r buurmans@192.168.2.202:/backups/Heimdall/home/buurmans/docker/ /home/buurmans/docker
```
Run ```docker compose up -d``` and win!