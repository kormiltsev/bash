bash notes
=====
Backet of bash scripts.

## Usage

### ftper.sh

Runs an FTP server in Docker container (uses fclairamb/ftpserver), using ports 2121-2130. Default directory is "$HOME/ftp/ftpdir"

Set direstory (optional):
```
./ftper.sh /dir/to/share
```

Help:
```
./ftper.sh -h
```

### newvm.sh

Sends certificcate to the remote host and save to $HOME/.ssh/config.

Add:
```
./newvm.sh myHostAlias root 0.0.0.0
```

List known hosts:
```
./newvm.sh la
```

Remove known hosts:
```
./newvm.sh rm myHostAlias
```

Help:
```
./newvm.sh -h
```

### go_builder.sh

Build a batch of binaries from go source. Default main file: ${PWD}/main.go, app name: directory name.

```
./go_builder.sh -h
```

### and other