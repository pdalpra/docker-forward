# docker-forward

## Goal

When using `boot2docker` or `docker-machine` with the VirtualBox driver,
you find very soon that mapping ports using the `-p` does indeed map your ports, but only to the VM running `boot2docker`, not your OS.

To mitigate this, you have 3 solutions:

* Use the VM IP to access the services running in your container: Works, but accessing them through `localhost` is easier, no ? :)
* Modify your `hosts` file so that hitting `localhost` ends up in hitting the VM running `boot2docker` : Works too, but if you use `docker-machine` and multiple VirtualBox `machines`, you'll need to do that for every machine...
* Forward the ports from your VM to you host: IMO the best solution, keeps the rules in the VM configuration, unlike modifying `hosts`

`docker-forward` aims to provide a simple way to manage your VM's ports forwardings, by: 

* dealing with VirtualBox CLI tools for you to forward/unforward ports on your VM
* Provide simple ways to know which ports are open

Although `docker-forward` is aimed at facilitating use of docker with `boot2docker`, it works with ANY VirtualBox VM.
## Requirements

Only `VBoxManage`, VirtualBox's CLI tool, which is installed along VirtualBox by default.
Everything else run on the common shell tools.

## Setup

Clone docker-forward :

```
git clone https://github.com/pdalpra/docker-forward.git ~/.bin/docker-forward
```

Then, in your `.bashrc`/`.zshrc`/your shell's startup file, add:

```
export PATH=$PATH:~/.bin/docker-forward/bin
eval $(docker-forward init -)
```

## Usage

### docker-forward vm

This commands allows to select which vm to manage. If you're using `boot2docker`, no configuration is needed,
as `boot2docker`'s VM, `boot2docker-vm` is selected by default.

`docker-forward vm` provide completions with all VirtualBox VMs in your VMs directory.

If you do not pass any arguments to `docker-forward vm`, it prints out the currently selected VM.

```bash
# Sets the current vm to 'my-vm'
$ docker-forward vm my-vm

# Prints out the current vm
$ docker-forward vm
my-vm
```

### docker-forward ports

`docker-forward ports` prints out all currently forwarded ports, for TCP and UDP.

```bash
$ docker-forward ports
TCP ports: 22 3000 8080
UDP ports: 2003
```

### docker-forward add / docker-forward add-tcp / docker-forward add-udp

Those commands allows you forward a port either on TCP, UDP protocol or both.

```bash 

# Forward on TCP and UDP
$ docker-forward add 2003
TCP port 2003 is now forwarded.
UDP port 2003 is now forwarded.

# Forward on TCP only
$ docker-forward add-tcp 2003
TCP port 2003 is now forwarded.

# Forward on UDP only
$ docker-forward add-udp 2003
UDP port 2003 is now forwarded.
```

### docker-forward remove / docker-forward remove-tcp / docker-forward remove-udp

Those commands allows you 'unforward' a port either on TCP, UDP protocol or both.

```bash 

# Unforward on TCP and UDP
$ docker-forward remove 2003
TCP port 2003 is not forwarded anymore.
UDP port 2003 is not forwarded anymore.

# Unforward on TCP only
$ docker-forward remove-tcp 2003
TCP port 2003 is not forwarded anymore.

# Unforward on UDP only
$ docker-forward remove-udp 2003
UDP port 2003 is not forwarded anymore.
```
