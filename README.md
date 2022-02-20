# Snowflakes

Track _unstable_ as I'm used to Arch Linux and the rolling release paradigm.
Beyond the initial [installation procedures](./INSTALL.md), nothing on the
system should be configured ad hoc.

```
$ sudo nixos-rebuild switch --flake github:elasticdog/snowflakes
```

## Development Workflow

```
$ nix flake clone github:elasticdog/snowflakes
$ cd snowflakes/
$ sudo nixos-rebuild test --flake .#
```
