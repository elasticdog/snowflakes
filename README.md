# Snowflakes

> "These are my snowflakes. There are many like them, but these are mine. My
> snowflakes are my best friends. They are my life. I must master them as I must
> master my life. Without me, my snowflakes are useless. Without my snowflakes,
> I am useless. I must configure my snowflakes true."

Track _unstable_ as I'm used to Arch Linux and the rolling release paradigm.
Beyond the initial [installation procedures](./INSTALL.md), nothing on these
systems should be configured ad hoc.

```
$ sudo nixos-rebuild switch --flake github:elasticdog/snowflakes
```

## Development Workflow

```
$ nix flake clone github:elasticdog/snowflakes
$ cd snowflakes/
$ sudo nixos-rebuild test --flake .#
```
