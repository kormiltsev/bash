# ALIASES

BASH scrypt to add aliases into `~/.bash_aliases`. Skip existed aliases and commands. 
Prints to STDOUT alias if conflict like this:

New alias for same command:
```
alias exists:
alias showmeip='ifconfig | grep broadcast'
alias ip='ifconfig | grep broadcast'
============
```

New command for the same alias:
```
alias exists:
alias printslow='pv -qL 100'
alias printslow='pv -qL 200'
============

```

### Set new aliases

List of new aliases set up in `./new_aleases` line by line

### Reboot system or run:
```
source ~/.bashrc
```