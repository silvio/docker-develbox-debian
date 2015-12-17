
Docker container for android/openembedded development

# start

Simple start via `docker run` and your main development folder as background
process.

    $ docker run -d -v /development:/development --name dev dandroid

Maybe you need privileged access to some device nodes you can use `--device`
option for `docker run`. Example:

    $ docker run -v /development:/development --device /dev/sda:/dev/sda

## environment variables

This variables (set via `-e` at start time) are evaluated:

* `DTIMEZONE`: setup the timezone (defaults to `Europe/Berlin`)
* `DUSERNAME`: username for internal user (defaults to `oe`)
* `DUSERID`: uder id for internal user (defaults to `1000`)
* `DGROUPNAME`: groupname for internal group (defaults to `oe`)
* `DGROUPID`: group id for internal group (defaults to `1000`)
* `DPASSWD`: password for this user (defaults to oe), is used for login via ssh

# connect

This container runs a ssh-server, just connect via ssh and consider to use
forwarding options like `-X` or/and `-A`. To prevent of adding this temporary
host to your known_host you can add `-o StrictHostKeyChecking=no -o
CheckHostIP=no`.

The passwords for `root` and `oe` are identical and set to `oe`.

This container is prepared with [sbc]. For connection you have to use the
username and password from the environment.

    $ docker inspect -f '{{ .NetworkSettings.IPAddress }}' dev
    172.17.0.2
    $ sbc ssh -XA -o StrictHostKeyChecking=no -o CheckHostIP=no oe@172.17.0.2

[sbc]: https://github.com/turicas/sbc

