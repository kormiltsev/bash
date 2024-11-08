bash notes
=====
Backet of bash scripts.

## Usage
```
-h to get help for each script
```
### ftper.sh

Runs an FTP server in Docker container (uses fclairamb/ftpserver), using ports 2121-2130. Default directory is "$HOME/ftp/ftpdir". Ok for tests.

Direstory is optional:
```
./ftper.sh
./ftper.sh </dir/to/share>
```

### newvm.sh
Sends certificate to the remote host and save myHostAlias to $HOME/.ssh/config. 
So next connection can be without password and called by alias. 
Useful in case of test VM with login/password.

Add new host alias:
```
./newvm.sh <alias> <username> <IP>
./newvm.sh myHostAlias root 0.0.0.0
ssh myHostAlias
```

List of aliases:
```
./newvm.sh ls
./newvm.sh la
```

Remove known host:
```
./newvm.sh rm myHostAlias
```

### go_builder.sh
Build a batch of binaries from go source. The main.go is expected here by default: `${PWD}/main.go`. The binary default name: directory name.

```
./go_builder.sh
./go_builder.sh <binaryName> <sourceName> 
```

### TBD
