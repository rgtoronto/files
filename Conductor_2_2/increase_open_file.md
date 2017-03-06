Increase max number of ulimit open file in Linux

1.Step : open the sysctl.conf and add this line  fs.file-max = 65536

$ vi /etc/sysctl.conf
add new line and

fs.file-max = 65536
save and exit.

2.Step:

$ vi /etc/security/limits.conf
and add below the mentioned

* soft     nproc          65535
* hard     nproc          65535
* soft     nofile         65535
* hard     nofile         65535
save and exit check max open file ulimit

# ulimit -a

....
open files                      (-n) 65535