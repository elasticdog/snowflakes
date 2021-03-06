# Snowflakes

![Sway Window Manager Screenshot](./screenshot.png)

> _"These are my snowflakes. There are many like them, but these are mine. My
> snowflakes are my best friends. They are my life. I must master them as I must
> master my life. Without me, my snowflakes are useless. Without my snowflakes,
> I am useless. I must configure my snowflakes true."_

Beyond the initial [installation procedures](./INSTALL.md), nothing on these
hosts should be configured imperatively.

| Hostname  | User |
| --------- | ---- |
| holystone | abs  |

```
snowflakes/
├── home/
│   └── abs/
│       ├── configs/
│       │   ├── firefox/
│       │   ├── fish/
│       │   ├── git/
│       │   ├── sway/
│       │   └── [...]
│       ├── common.nix
│       └── holystone.nix
├── hosts/
│   └── holystone/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── [...]
├── modules/
│   ├── audio.nix
│   ├── common.nix
│   ├── nix.nix
│   ├── services.nix
│   ├── users.nix
│   └── [...]
├── flake.lock
└── flake.nix
```

## Usage

    $ sudo nixos-rebuild switch --flake github:elasticdog/snowflakes

### Development Workflow

    $ nix flake clone github:elasticdog/snowflakes
    $ cd snowflakes/
    $ sudo nixos-rebuild test --flake .#

## Unstable is Life

- [NixOS Manual](https://nixos.org/manual/nixos/unstable/index.html)
- [NixOS Configuration Options](https://nixos.org/manual/nixos/unstable/options.html)
- [Nix (builtins) & Nixpkgs (lib) Functions](https://teu5us.github.io/nix-lib.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/index.html)
- [Home Manager Configuration Options](https://nix-community.github.io/home-manager/options.html)

## License

Snowflakes is provided under the terms of the
[MIT License](https://en.wikipedia.org/wiki/MIT_License).

Copyright &copy; 2022, [Aaron Bull Schaefer](mailto:aaron@elasticdog.com).
