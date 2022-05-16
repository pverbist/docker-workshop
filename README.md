# OneSpan workshop

## Hello docker
Log in and check if docker is running fine.

```
$ docker info
```

You first need to have an image before you can spin up one. The place where all public images are kept is the [docker hub](https://hub.docker.com). Most default projects can be found on there. Let's download our first image called [hello world](https://hub.docker.com/_/hello-world/).

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
$ docker pull hello-world
Using default tag: latest
latest: Pulling from library/hello-world
4276590986f6: Pull complete
a3ed95caeb02: Pull complete
Digest: sha256:a7d7a8c072a36adb60f5dc932dd5caba8831ab53cbf016bcdd6772b3fbe8c362
Status: Downloaded newer image for hello-world:latest
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              94df4f0ce8a4        5 weeks ago         967 B
```
To start up this docker image, run following:

```
$ docker run hello-world

Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/

```
It might be trivial, but in the background, it started up the image or container called hello-world, launched what is defined and stopped.

> The difference between an image and container is as follows:
> 
> - An image is an ordered collection of root filesystems and does not have a state.
> - A container is a runtime instance of a docker image and can be stopped or started.

In the hello-world example, the container was started, showed the `Hello from Docker.` message and exited.

You can check the state of docker containers with the `ps` command.

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
cb914576e3bb        hello-world         "/hello"            9 minutes ago       Exited (0) 9 minutes ago                       evil_goodall
```
The `docker ps` command will only show the running docker containers. You need to specify the `-a` for it to show all state containers.

Instead of 2 steps, running first a docker pull and docker run command, this can go in one step, but let's clean up first.
To clean the container, you can use following command:

```
$ docker rm cb914576e3bb
cb914576e3bb
```
where `cb914576e3bb` is the unique container id.

Next you can remove the image from the local repo.

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              94df4f0ce8a4        5 weeks ago         967 B
$ docker rmi 94df4f0ce8a4
Untagged: hello-world:latest
Deleted: sha256:94df4f0ce8a4d4d4c030b9bdfe91fc9cf6a4b7be914542315ef93a046d520614
Deleted: sha256:92953e7618fbb0f7991146fccf4da3dc31e1b5104b6d6c9572ee75d3eba240a2
Deleted: sha256:33e7801ac047e45517f22927037407c9753aa27ed72a5932c3e0886477041b12
```
where `94df4f0ce8a4` is the unique image id.
Check if everything is cleaned up and run the same `hello-world` example in one go.

```
$ docker ps -s
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES               SIZE
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4276590986f6: Pull complete
a3ed95caeb02: Pull complete
Digest: sha256:a7d7a8c072a36adb60f5dc932dd5caba8831ab53cbf016bcdd6772b3fbe8c362
Status: Downloaded newer image for hello-world:latest

Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/

 $ docker images
 REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
 hello-world         latest              94df4f0ce8a4        5 weeks ago         967 B
 $ docker ps -a
 CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                          PORTS               NAMES
 5a9941319a1a        hello-world         "/hello"            About a minute ago   Exited (0) About a minute ago                       gloomy_heisenberg
```

## Playing with Alpine
Enough with the hello-world, let's start playing with an OS. Next OS is called alpine linux. It's a minimal Linux and is based on busybox.
Let's search for the image on the docker hub:

```
$ docker search alpine
NAME                           DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
alpine                         A minimal Docker image based on Alpine Lin...   1009      [OK]       
anapsix/alpine-java            Oracle Java 8 (and 7) with GLIBC 2.23 over...   100                  [OK]
frolvlad/alpine-glibc          Alpine Docker image with glibc (~12MB)          27                   [OK]
container4armhf/armhf-alpine   Automatically built base images of Alpine ...   18                   [OK]
zzrot/alpine-caddy             Caddy Server Docker Container running on A...   14                   [OK]
smebberson/alpine-base         An Alpine Linux base image, featuring s6 p...   10                   [OK]
janeczku/alpine-kubernetes     Alpine Linux base image with full support ...   10                   [OK]
...
```

We're going to use the official image. Let's start alpine in one go:

```
$ docker run -i -t alpine /bin/sh
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fae91920dcd4: Already exists 
Digest: sha256:ea0d1389812f43e474c50155ec4914e1b48792d420820c15cab28c0794034950
Status: Downloaded newer image for alpine:latest
/ # hostname
84b5b0bfcc0a
/ # exit
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
84b5b0bfcc0a        alpine              "/bin/sh"           20 seconds ago      Exited (0) 4 seconds ago                       pensive_austin
```
What we just did was download the alpine image (because it wan't on our system), start up the container and started an interactive `-i` tty `-t` session launching the shell command `/bin/sh`

If you issue the same commands again, it will go over the complete iteration again. Meaning it will look for an image called `alpine` locally. If not, docker will download it, and start up a new container.

```
$ docker run -i -t alpine /bin/sh
/ # hostname
72793de5324a
/ # exit
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                          PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           10 seconds ago       Exited (0) 4 seconds ago                            loving_newton
84b5b0bfcc0a        alpine              "/bin/sh"           About a minute ago   Exited (0) About a minute ago                       pensive_austin
```
We can see now that we have 2 containers and that they are stopped. Let's start one up and log in:

```
$ docker run -i -t alpine /bin/sh
/ # hostname
72793de5324a
/ # exit
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                          PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           10 seconds ago       Exited (0) 4 seconds ago                            loving_newton
84b5b0bfcc0a        alpine              "/bin/sh"           About a minute ago   Exited (0) About a minute ago                       pensive_austin
$ docker start 72793de5324a
72793de5324a
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           About a minute ago   Up 7 seconds                            loving_newton
$ docker exec -it 72793de5324a sh
/ # hostname
72793de5324a
/ # exit
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                     PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           About a minute ago   Up 53 seconds                                  loving_newton
84b5b0bfcc0a        alpine              "/bin/sh"           3 minutes ago        Exited (0) 3 minutes ago                       pensive_austin
```
We can see that this machine stays up when logging in and out. Instead of the unique container id, we can also use the unique name docker is generating for us.

```
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                     PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           About a minute ago   Up 53 seconds                                  loving_newton
84b5b0bfcc0a        alpine              "/bin/sh"           3 minutes ago        Exited (0) 3 minutes ago                       pensive_austin
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
72793de5324a        alpine              "/bin/sh"           2 minutes ago       Up About a minute                       loving_newton
$ docker exec -it loving_newton sh
/ # hostname
72793de5324a
/ # exit
```

Or create one with a name of our own and in daemon mode

```
$ docker run --name alpine_the_container -d alpine /bin/sh -c "while true; do ping 8.8.8.8; done"
```

Show container logs (exit with CTRL+C)

```
$ docker logs -f alpine_the_container
```

Couple of commands that can help you:
List running containers

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
d277c013bd27        alpine              "/bin/sh -c 'while tr"   About a minute ago   Up About a minute                       alpine_the_container
72793de5324a        alpine              "/bin/sh"           2 minutes ago       Up 2 minutes                                         loving_newton
```

Stop a running container

```
$ docker stop loving_newton
loving_newton
```

Running a top like command in a container

```
$ docker stats alpine_the_container
```

Automatically remove the container when stopped

```
$ docker run --rm -ti alpine /bin/sh
```

One very handy is running an inspect from a docker container. This will be used a lot!

```
$ docker inspect alpine_the_container
```

Obtain mac address and IP information

```
$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' alpine_the_container
02:42:ac:11:00:02
$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' alpine_the_container
172.17.0.2
```

Or by logging in and requesting

```
$ docker exec -it alpine_the_container ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
25: eth0@if26: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:acff:fe11:2/64 scope link 
       valid_lft forever preferred_lft forever
```


## Working in a container
Checking out the docker container:

```
$ docker start loving_newton
loving_newton
$ docker attach loving_newton
/ # pstree
sh---pstree
/ # ls
bin      dev      etc      home     lib      linuxrc  media    mnt      proc     root     run      sbin     srv      sys      tmp      usr      var
/ # id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
/ # cd /home
/home # touch foo bar
/home # ls
bar  foo
/home # exit
$ docker diff loving_newton
C /root
A /root/.ash_history
C /home
A /home/bar
A /home/foo
$ docker attach loving_newton
You cannot attach to a stopped container, start it first
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eedce274688b        alpine              "/bin/sh -c 'while tr"   17 minutes ago      Up 17 minutes                           alpine_the_container
$ docker start loving_newton
loving_newton
```

As you can see, when you use the `attach` command and exit, the container will stop.

Let's try to pause a container

```
$ docker pause loving_newton
loving_newton
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                   PORTS               NAMES
eedce274688b        alpine              "/bin/sh -c 'while tr"   18 minutes ago      Up 18 minutes                                alpine_the_container
72793de5324a        alpine              "/bin/sh"                24 minutes ago      Up 20 seconds (Paused)                       loving_newton
$ docker unpause loving_newton
loving_newton
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eedce274688b        alpine              "/bin/sh -c 'while tr"   18 minutes ago      Up 18 minutes                           alpine_the_container
72793de5324a        alpine              "/bin/sh"                24 minutes ago      Up 39 seconds                           loving_newton
```


## Cleaning up
Do try and clean up. Running - trying out running containers over and over again can take up some disk space. Cleaning up is necessary. 

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eedce274688b        alpine              "/bin/sh -c 'while tr"   19 minutes ago      Up 19 minutes                           alpine_the_container
72793de5324a        alpine              "/bin/sh"                25 minutes ago      Up About a minute                       loving_newton
$ docker ps -q
eedce274688b
72793de5324a
$ docker stop $(docker ps -q)
eedce274688b
72793de5324a
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
eedce274688b        alpine              "/bin/sh -c 'while tr"   20 minutes ago      Exited (137) 14 seconds ago                       alpine_the_container
72793de5324a        alpine              "/bin/sh"                26 minutes ago      Exited (137) 3 seconds ago                        loving_newton
84b5b0bfcc0a        alpine              "/bin/sh"                28 minutes ago      Exited (0) 27 minutes ago                         pensive_austin
$ docker ps -a -q
eedce274688b
72793de5324a
84b5b0bfcc0a
$ docker rm $(docker ps -a -q)
eedce274688b
72793de5324a
84b5b0bfcc0a
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              latest              f70c828098f5        5 days ago          4.795 MB
$ docker images -q
f70c828098f5
$ docker rmi $(docker images -q)
Untagged: alpine:latest
Deleted: sha256:f70c828098f57d1f3fc678402c23450097aa4ee6963aa22913c0b10375ce366e
```

> So to clean up running containers - stopped containers - images, only 3 commands suffice:
> 
> - docker stop $(docker ps -q)
> - docker rm $(docker ps -a -q)
> - docker rmi $(docker images -q)


## Building an image
Let's build our first image. 

```
$ docker run -i -t alpine /bin/sh
```

And run following commands:

```
apk update        # to update the alpine container
apk add ruby      # to install ruby on it
mkdir average
cd average
echo "#!/usr/bin/env ruby
# Kimat's average ruby code
sum = 0
ARGV.each do |el|
  sum += el.to_i
end
p sum/ARGV.size.to_f" | tee average.rb
chmod +x average.rb
```

Test:

```
./average.rb 4 5 6 7 8 
6.0
```

Before building the image, we must know it's unique hostname. Exit the container and build it:

```
/ # hostname
02663f50a10f
/ # exit
$ docker commit -m "Installed ruby and wrote Kimat's average" 02663f50a10f
sha256:0e6d89b6cdf187c37721c2606e2e61e1f577d18966358d75cd6520abbe4e5ba5
```

Try it out:

```
$ docker run 0e6d89b6cdf average/average.rb 4 5 6
5.0
```



## Dockerfile
Let's build our own images. They all start with a `Dockerfile` where we will inform the deployer how and what he needs to do.

```
cd example01
$ cat Dockerfile 
FROM alpine
MAINTAINER Peter Verbist <peter.verbist@vasco.com>
RUN apk update && apk add ruby
RUN mkdir average
ADD average.rb average/
WORKDIR average
ENTRYPOINT ["ruby","average.rb"]

$ cat average.rb 
#!/usr/bin/env ruby
# Kimat's average ruby code
sum = 0
ARGV.each do |el|
  sum += el.to_i
end
p sum/ARGV.size.to_f
```

So in that file is said that docker needs to take the image called alpine, and it should be the latest release. The maintainer is yourself, and then there will be a command to update and install ruby. Create the directory `average` and copying the file `average.rb` in that directory. The workdir will be `average` and `ruby` will execute `average.rb`.

Now let's build the image:

```
$ docker build -t pverbist/average .
Sending build context to Docker daemon 3.072 kB
Step 1 : FROM alpine
 ---> f70c828098f5
Step 2 : MAINTAINER Peter Verbist <peter.verbist@vasco.com>
 ---> Running in ed62b1fc61df
 ---> a4374dc62e87
Removing intermediate container ed62b1fc61df
Step 3 : RUN apk update && apk add ruby
 ---> Running in 5a3713a21c3a
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/APKINDEX.tar.gz
v3.4.0-8-ge33120d [http://dl-cdn.alpinelinux.org/alpine/v3.4/main]
v3.4.0-9-g9308354 [http://dl-cdn.alpinelinux.org/alpine/v3.4/community]
OK: 5953 distinct packages available
(1/10) Installing ncurses-terminfo-base (6.0-r7)
(2/10) Installing ncurses-terminfo (6.0-r7)
(3/10) Installing ncurses-libs (6.0-r7)
(4/10) Installing libedit (20150325.3.1-r3)
(5/10) Installing libffi (3.2.1-r2)
(6/10) Installing gdbm (1.11-r1)
(7/10) Installing gmp (6.1.0-r0)
(8/10) Installing yaml (0.1.6-r1)
(9/10) Installing ruby-libs (2.3.1-r0)
(10/10) Installing ruby (2.3.1-r0)
Executing busybox-1.24.2-r8.trigger
OK: 27 MiB in 21 packages
 ---> b1ce9496d0a0
Removing intermediate container 5a3713a21c3a
Step 4 : RUN mkdir average
 ---> Running in b62b1790317c
 ---> 43cd51b76e30
Removing intermediate container b62b1790317c
Step 5 : ADD average.rb average/
 ---> 17d041259161
Removing intermediate container 05cce446dddc
Step 6 : WORKDIR average
 ---> Running in cc6adbeb0369
 ---> e6c08d0bd01e
Removing intermediate container cc6adbeb0369
Step 7 : ENTRYPOINT ruby average.rb
 ---> Running in 863f91a58af2
 ---> 25b25ca1014f
Removing intermediate container 863f91a58af2
Successfully built 25b25ca1014f
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
pverbist/average    latest              25b25ca1014f        5 seconds ago       21.15 MB
<none>              <none>              0e6d89b6cdf1        4 minutes ago       21.15 MB
alpine              latest              f70c828098f5        5 days ago          4.795 MB
```

Now let's run it:

```
$ docker run pverbist/average 3 4 5
4.0
```

WICKED! We just launched our first container!

Lets build the same docker image and have a look at it's speed:

```
$ docker build -t pverbist/average .
Sending build context to Docker daemon 3.072 kB
Step 1 : FROM alpine
 ---> f70c828098f5
Step 2 : MAINTAINER Peter Verbist <peter.verbist@vasco.com>
 ---> Using cache
 ---> a4374dc62e87
Step 3 : RUN apk update && apk add ruby
 ---> Using cache
 ---> b1ce9496d0a0
Step 4 : RUN mkdir average
 ---> Using cache
 ---> 43cd51b76e30
Step 5 : ADD average.rb average/
 ---> Using cache
 ---> 17d041259161
Step 6 : WORKDIR average
 ---> Using cache
 ---> e6c08d0bd01e
Step 7 : ENTRYPOINT ruby average.rb
 ---> Using cache
 ---> 25b25ca1014f
Successfully built 25b25ca1014f
```
Did you notice the speed of creating this image? Reason is that everything is cached.

## Using Mounts
A mount is a persistent store that is shared between the host and the container. You can compare this with a regular linux mount where you are going to map from something towards something.

```
$ echo foo > bar
$ docker run --rm -it -v $(pwd):/mnt alpine sh
/ # cat /mnt/bar
foo
/ # echo test >> /mnt/bar
/ # exit
$ cat bar
foo
test
```
In this case the `$(pwd)` is the current directory. This will be mapped the `/mnt` directory in the alpine container. 

## Running your first web application
We'll use a python web application. The web application will store the number of page views in a [redis](http://redis.io) container and display this on the page.

First we'll install redis container and make the ports available to access. The default redis port is 6379. We'll map it to our localhost like this:

```
$ cd example02
$ docker run -d -p 6379:6379 --name redis redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
214ca5fb9032: Pull complete
9eeabf2ad250: Pull complete
b8eb79a9f3c4: Pull complete
0ba9bf1b547e: Pull complete
2d2e2b28e876: Pull complete
3e45fcdfb831: Pull complete
Digest: sha256:ad0705f2e2344c4b642449e658ef4669753d6eb70228d46267685045bf932303
Status: Downloaded newer image for redis:latest
a5a577fafa84e6ebcfe0656c0611f1bc8b7284f1959ab9613b751b29b9ba96fc
$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                       NAMES
a5a577fafa84   redis     "docker-entrypoint.s…"   20 seconds ago   Up 18 seconds   0.0.0.0:6379->6379/tcp, :::6379->6379/tcp   redis
```

Once we've fired up redis, we can start creating our web app:
```
$ cat app.py
import time

import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello World! I have been seen {} times.\n'.format(count)

$ cat requirements.txt
flask
redis
```

And create the Dockerfile:

```
$ cat Dockerfile
FROM python:3.7-alpine
WORKDIR /code
ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
CMD ["flask", "run"]
```

Now let's build the docker image:

```
$ docker build -t pverbist/counter .
Sending build context to Docker daemon  4.608kB
Step 1/9 : FROM python:3.7-alpine
3.7-alpine: Pulling from library/python
df9b9388f04a: Already exists
a1ef3e6b7a02: Already exists
592c86358a0b: Already exists
cb59fb21dd58: Already exists
4304e370afec: Already exists
Digest: sha256:ad5383edd0d9109639a44d725314d1f37af256e81c86a04a0e8e077f899f63ca
Status: Downloaded newer image for python:3.7-alpine
 ---> 56dc68fee36a
Step 2/9 : WORKDIR /code
 ---> Running in 111cbe1385d0
Removing intermediate container 111cbe1385d0
 ---> a679447d364a
Step 3/9 : ENV FLASK_APP app.py
 ---> Running in b7b80bd32891
Removing intermediate container b7b80bd32891
 ---> eba9769ba9a2
Step 4/9 : ENV FLASK_RUN_HOST 0.0.0.0
 ---> Running in eec057334e99
Removing intermediate container eec057334e99
 ---> 97f192dcad86
Step 5/9 : RUN apk add --no-cache gcc musl-dev linux-headers
 ---> Running in 8f6907309ae3
fetch https://dl-cdn.alpinelinux.org/alpine/v3.15/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.15/community/x86_64/APKINDEX.tar.gz
(1/13) Installing libgcc (10.3.1_git20211027-r0)
(2/13) Installing libstdc++ (10.3.1_git20211027-r0)
(3/13) Installing binutils (2.37-r3)
(4/13) Installing libgomp (10.3.1_git20211027-r0)
(5/13) Installing libatomic (10.3.1_git20211027-r0)
(6/13) Installing libgphobos (10.3.1_git20211027-r0)
(7/13) Installing gmp (6.2.1-r1)
(8/13) Installing isl22 (0.22-r0)
(9/13) Installing mpfr4 (4.1.0-r0)
(10/13) Installing mpc1 (1.2.1-r0)
(11/13) Installing gcc (10.3.1_git20211027-r0)
(12/13) Installing linux-headers (5.10.41-r0)
(13/13) Installing musl-dev (1.2.2-r7)
Executing busybox-1.34.1-r5.trigger
OK: 143 MiB in 49 packages
Removing intermediate container 8f6907309ae3
 ---> 7d6301dbc2c1
Step 6/9 : COPY requirements.txt requirements.txt
 ---> 4bba1ab2fff2
Step 7/9 : RUN pip install -r requirements.txt
 ---> Running in 91a2508d1ee9
Collecting flask
  Downloading Flask-2.1.2-py3-none-any.whl (95 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 95.2/95.2 KB 10.8 MB/s eta 0:00:00
Collecting redis
  Downloading redis-4.3.1-py3-none-any.whl (241 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 241.2/241.2 KB 25.3 MB/s eta 0:00:00
Collecting Werkzeug>=2.0
  Downloading Werkzeug-2.1.2-py3-none-any.whl (224 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 224.9/224.9 KB 27.5 MB/s eta 0:00:00
Collecting importlib-metadata>=3.6.0
  Downloading importlib_metadata-4.11.3-py3-none-any.whl (18 kB)
Collecting itsdangerous>=2.0
  Downloading itsdangerous-2.1.2-py3-none-any.whl (15 kB)
Collecting Jinja2>=3.0
  Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 133.1/133.1 KB 13.4 MB/s eta 0:00:00
Collecting click>=8.0
  Downloading click-8.1.3-py3-none-any.whl (96 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 96.6/96.6 KB 14.0 MB/s eta 0:00:00
Collecting deprecated>=1.2.3
  Downloading Deprecated-1.2.13-py2.py3-none-any.whl (9.6 kB)
Collecting typing-extensions
  Downloading typing_extensions-4.2.0-py3-none-any.whl (24 kB)
Collecting packaging>=20.4
  Downloading packaging-21.3-py3-none-any.whl (40 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 40.8/40.8 KB 8.5 MB/s eta 0:00:00
Collecting async-timeout>=4.0.2
  Downloading async_timeout-4.0.2-py3-none-any.whl (5.8 kB)
Collecting wrapt<2,>=1.10
  Downloading wrapt-1.14.1-cp37-cp37m-musllinux_1_1_x86_64.whl (80 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 80.6/80.6 KB 14.3 MB/s eta 0:00:00
Collecting zipp>=0.5
  Downloading zipp-3.8.0-py3-none-any.whl (5.4 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.1.1-cp37-cp37m-musllinux_1_1_x86_64.whl (30 kB)
Collecting pyparsing!=3.0.5,>=2.0.2
  Downloading pyparsing-3.0.9-py3-none-any.whl (98 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 98.3/98.3 KB 16.6 MB/s eta 0:00:00
Installing collected packages: zipp, wrapt, Werkzeug, typing-extensions, pyparsing, MarkupSafe, itsdangerous, packaging, Jinja2, importlib-metadata, deprecated, async-timeout, redis, click, flask
Successfully installed Jinja2-3.1.2 MarkupSafe-2.1.1 Werkzeug-2.1.2 async-timeout-4.0.2 click-8.1.3 deprecated-1.2.13 flask-2.1.2 importlib-metadata-4.11.3 itsdangerous-2.1.2 packaging-21.3 pyparsing-3.0.9 redis-4.3.1 typing-extensions-4.2.0 wrapt-1.14.1 zipp-3.8.0
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
WARNING: You are using pip version 22.0.4; however, version 22.1 is available.
You should consider upgrading via the '/usr/local/bin/python -m pip install --upgrade pip' command.
Removing intermediate container 91a2508d1ee9
 ---> 5ade3bf3e5e2
Step 8/9 : COPY . .
 ---> 1f1883fd0342
Step 9/9 : CMD ["flask", "run"]
 ---> Running in 699dbc30d30f
Removing intermediate container 699dbc30d30f
 ---> 5d6a21af3a2b
Successfully built 5d6a21af3a2b
Successfully tagged pverbist/counter:latest
```

Let's start up the new app. Remember to map redis to redis!

```
$ docker run --name web --link redis:redis -p 5000:5000 -d pverbist/counter
```

Test with curl command:
```
$ curl http://0:5000
Hello World! I have been seen 1 times.
$ curl http://0:5000
Hello World! I have been seen 2 times.
$ curl http://0:5000
Hello World! I have been seen 3 times.
```

Open up with ngrok
```
$ AUTH_TOKEN=YOUR_TOKEN
$ docker run --net=host -it -e NGROK_AUTHTOKEN=$AUTH_TOKEN ngrok/ngrok:latest http 5000
```

Clean up
```
$ docker stop `docker ps -aq`
$ docker rm `docker ps -aq`
```

## docker compose
```
$ docker-compose --version
Docker Compose version v2.5.0
$ docker compose version
Docker Compose version v2.5.0
```

Go to example03. This is the same counter but now with docker compose
```
$ cd ../example03
$ cat docker-compose.yml
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"

$ docker compose up

$ docker compose up -d

$ docker compose down

$ docker compose up redis -d
$ docker compose up web -d
$ docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
example03-redis-1   "docker-entrypoint.s…"   redis               running             6379/tcp
example03-web-1     "flask run"              web                 running             0.0.0.0:5000->5000/tcp, :::5000->5000/tcp
```

## Create a wordpress application
### First we need a mysql database running

```
$ cd ../example04
$ docker run -e MYSQL_ROOT_PASSWORD=wordpress -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest
c03ef3a8c9e0c1c1559a1de1c2096f4da0306b5254724fc0380fa483e2b3b0fe
$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS      NAMES
c03ef3a8c9e0   mariadb:latest   "docker-entrypoint.s…"   8 seconds ago   Up 7 seconds   3306/tcp   wordpressdb
$ docker exec -ti wordpressdb bash
root@18fadabe04f5:/# mysql -u root -pwordpress
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 3
Server version: 10.7.3-MariaDB-1:10.7.3+maria~focal mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.001 sec)

MariaDB [(none)]> use wordpress;
Database changed
MariaDB [wordpress]> show tables;
Empty set (0.000 sec)

MariaDB [wordpress]> exit
Bye
root@18fadabe04f5:/# exit
exit
```

Stop and start mysql db

```
$ docker run -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=wordpress --name wordpress --link wordpressdb:mysql -p 80:80 -v "$PWD/html":/var/www/html -d wordpress
c376125d635add21eba33e66062fabd14c21e1c8da773deadbf27adb3ebe344e
$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                               NAMES
c376125d635a   wordpress        "docker-entrypoint.s…"   6 seconds ago    Up 5 seconds    0.0.0.0:80->80/tcp, :::80->80/tcp   wordpress
c03ef3a8c9e0   mariadb:latest   "docker-entrypoint.s…"   45 seconds ago   Up 44 seconds   3306/tcp                            wordpressdb
```

```
docker run --net=host -it -e NGROK_AUTHTOKEN=$AUTH_TOKEN ngrok/ngrok:latest http 80
```

Clean up
```
$ docker stop wordpress wordpressdb
$ docker rm wordpress wordpressdb
```

## Your turn
Same app but with phpmyadmin

```
$ cat docker-compose.yaml
version: "3.9"

services:
  db:
    image: mariadb:latest
    volumes:
      - $PWD/database:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    volumes:
      - $PWD/html:/var/www/html
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress

  phpmyadmin:
    depends_on:
      - db
    image: phpmyadmin:latest
    ports:
      - 8181:80
    environment:
      PMA_HOST: db
      PMA_USER: root
      PMA_PASSWORD: wordpress
```


## Last one, asp

```
cd ../example06
docker build -t pverbist/asp .
docker run -p 8000:80 pverbist/asp
```
