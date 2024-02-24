### Setting up a new keycloak instance

- Upload `Dockerrun.aws.json` to elastic-beanstalk and deploy directly,
  it will instantiate a docker container in an ec2-instance.
  You also need to set the environment variables in elasticbeanstalk config for db configuration.

```json
// Dockerrun.aws.json
{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "jboss/keycloak:<version>"
  },
  "Ports": [
    {
      "ContainerPort": 9990,
      "HostPort": 9990
    },
    {
      "ContainerPort": 8080,
      "HostPort": 80
    },
    {
      "ContainerPort": 8443,
      "HostPort": 443
    }
  ]
}
```

- [Create a ssh connection](ssh-connection-ec2.md) with the ec2 instance.
- In ec2 instance go to container terminal

  ```console
  sudo docker ps -> to get container id
  sudo docker exec -it <container-id> bash
  ```

- Create a new keycloak root user `<user>:<password>` for master realm

  ```console
  opt/jboss/keycloak/bin/add-user-keycloak.sh --user <user> --password <password>
  ./jboss-cli.sh --connect command=:reload
  ```

- Use these credentials to login to keycloak admin dashboard.
