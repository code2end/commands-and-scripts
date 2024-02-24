# Install redis on ec2 linux instance

## amazon ec2 instance : AL_2023

**tmux - background session**

`sudo dnf install tmux`

**redis-cache**

```console
sudo dnf install -y redis6
sudo systemctl start redis6
sudo systemctl enable redis6
sudo systemctl is-enabled redis6
redis6-server --version
redis6-cli ping
```

## amazon ec2 instance : AL_2

**tmux - background session**

`sudo yum install tmux`

**redis-cache**

`sudo amazon-linux-extras install -y redis6
redis-server --daemonize yes
redis-cli ping`
