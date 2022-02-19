# Snowflakes

```
$ sudo nixos-rebuild switch --flake github:elasticdog/snowflakes
```

## Development Workflow

```
$ nix flake clone github:elasticdog/snowflakes
$ cd snowflakes/
$ sudo nixos-rebuild test --flake .#
```
