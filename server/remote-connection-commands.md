# Helpful commands for remote connections

### Secure connection to server instance

`ssh -i <ssh-file-path> <user@instance>`

### Secure copy

`scp -r <local-file-path> <user@instance>:<remote-file-path>`

### Remote redis connection

`src/redis-cli -c -h <cluster-url> -p 6379`
