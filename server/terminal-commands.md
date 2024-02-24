# Helpful commands for terminal

### Overall disk utilisation

`df -h`

### File disk usage

`du -sh <filename>`

### To print all data going to a particular port "20001"

`sudo tcpdump -i any dst port 20001 -A`

### To view a log file with actively logs printing

```console
less console.txt
[Shift + F to end of file]
```

### To view and kill the process

```console
ps aux | grep "<keyword>"
kill -9 <id>
```

### To run background process/session

```console
tmux new -s new-session
Attach - tmux a -t new-session
Detach - ctrl+b,d
```
