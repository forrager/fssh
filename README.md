## fssh

Easily ssh into remote Amazon EC2 hosts by name.  Eg. `fssh hellfire`.

## Installation

`gem install fssh`

## Setup

Add your Amazon security credentials as variables in your shell.  Usually this is done via a file like your `~/.bash_profile` or `~/.bashrc`:

```
export AMAZON_ACCESS_KEY_ID=...
export AMAZON_ACCESS_SECRET=...
```

Create the file `~/.fssh` that will contain your fssh config in YAML format.  Mine looks something like this:

```
:local_private_key_file: ~/.ssh/private.pem
:remote_private_key_file: /home/camertron/.ssh/private.pem
:gateway:
  - :name: bastion
    :except:
      - bastion
  - :name: bastion2
		:except:
			- bastion2
		:only:
			- hellfire
:username: camertron
```

1.  The local and remote key files should point to your Amazon-issued .pem file.  If you don't use a gateway, the remote key file isn't necessary since you don't need to hop more than once.
2.  You can specify more than one gateway and when to use it via the `:only` and `:except` options.  It's usually a good idea to put the gateway's name into the `:except` list since you don't want to connect to the gateway through itself (right?).  Use the `:only` list to indicate servers that should always be connected to via this gateway.  In the example above, a connection to the `hellfire` server will happen through the `bastion2` gateway.
3.  Specify the username you want to connect to the remote server as.

## Usage

SSH to and (optionally) run a command on a remote ec2 server:

`fssh server_name [command]`

Securely copy a file from a remote ec2 server to your local machine or vice-versa. For the most part, the `fscp` command uses the same `host:/path/` syntax that the `scp` command uses:

`fscp server_name:/remote_path local_path`

`fscp local_path, server_name:/remote_path`

## Requirements

The fssh gem assumes you have OpenSSH (or some variant) installed and that you're running some *nix-based operating system like Linux or Mac OS.  The `fscp` command also relies on the existence of netcat.

## Running Tests

`bundle exec rake` or `bundle exec rspec`

## Authors

* Cameron C. Dutro: http://github.com/camertron

## Links
* amazon-ec2 gem: [https://github.com/grempe/amazon-ec2](https://github.com/grempe/amazon-ec2)

## License

Copyright 2012 Forrager.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
