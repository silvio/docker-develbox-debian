
Docker container for android/openembedded development

# start

Simple start via `docker run` and your main development folder as background
process.

    $ docker run -d -v /development:/development --name dev dandroid

Maybe you need privileged access to some device nodes you can use `--device`
option for `docker run`. Example:

    $ docker run -v /development:/development --device /dev/sda:/dev/sda

# caveat

Please have in mind that all pathes have to be in the same place. Its a bad
idea to clone/compile/work on the host folder e.g. `/home` and mount this
folder into e.g. `/development` and use it in a docker container in the same
way.

If you have to manipulate devices in `/dev` you should mount it to e.g.
`/dev2`.

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

For connection you have to use the username and password from the environment.

    $ docker inspect -f '{{ .NetworkSettings.IPAddress }}' dev
    172.17.0.2
    $ sbc ssh -XA -o StrictHostKeyChecking=no -o CheckHostIP=no oe@172.17.0.2

## sbc

This container is prepared with [SBC]. SBC create a backchannel to you host
which can used for doing stuff remotely like edit file on your host.

    sbc gvim /etc/resolv.conf

The line above opens gvim on your host with the `/etc/resolv.conf` file of your
container.

You have to install sbc on your host too, please follow the sbc installation
manual.

### sbc notification

This image is prepared with two little scripts `sbcn` and `sbcc`. The `sbcn`
script prints a simple notification on your host. `sbcc` checks the last
`return` value and prints accordingly to the retunr value an `OK` or `KO` as
notification.

    resize2fs /dev/sdf5 ; sbcn
    bitbake image ; sbcc

[SBC]: https://github.com/turicas/sbc
