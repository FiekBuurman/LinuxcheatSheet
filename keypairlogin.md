```
ssh-keygen -t ed25519 -C "USERNAME default"
```
 - "Enter file in which to save the key (/home/USERNAME/.ssh/id_ed25519)"
 - stored in /home/USERNAME/.ssh/id_ed25519.pub
```
ssh-copy-id -i  /home/USERNAME/.ssh/id_ed25519.pub 10.10.10.10
```