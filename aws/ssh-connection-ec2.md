# Create a ssh connection

- Get ssh certificate for ec2 instance from aws console
- move ssh file to .ssh folder and run

```terminal
chmod 400 <file>.pem
ssh -i "<file>" <user>@<host>
```
