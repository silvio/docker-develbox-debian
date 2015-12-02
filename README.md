
Docker container for android/openembedded development

# start

Simple start via `docker run` and your main development folder as background
process.

    $ docker run -d -v /development:/development --name dev dandroid

Maybe you need access to some device nodes you can use `--device` option for
`docker run`. Example:

    $ docker run -v /development:/development --device /dev/sda:/dev/sda

# connect

This container runs a ssh-server, just connect via ssh and consider to use
forwarding options like `-X` or/and `-A`. To prevent of adding this temporary
host to your known_host you can add `-o StrictHostKeyChecking=no -o CheckHostIP=no`.

The passwords for `root` and `oe` are identical and set to `oe`.

This container is prepared with [sbc].

    $ docker inspect -f '{{ .NetworkSettings.IPAddress }}' dev
    172.17.0.2
    $ sbc ssh -XA -o StrictHostKeyChecking=no -o CheckHostIP=no oe@172.17.0.2

[sbc]: https://github.com/turicas/sbc

