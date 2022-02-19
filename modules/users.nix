# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  users.users.abs = {
    isNormalUser = true;
    home = "/home/abs";
    description = "Aaron Bull Schaefer";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "correct horse battery staple";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzBGmg7fI+H7WfJWhSdRUo3nRcEpv3qvqmoMvucGkwxfIlEFN5swH1bodmIq0m2OznoNPV4b2A/++x8R4VqgPPK5VZabH6eRiJWM3IC3Cb2vmgaOsss8NgNxKQ2I3hUWmTHh6P+vkMP13VrS8ZI8TaZSpqiTOg2KTLllHp7hHwkhhhYF98iWT+pu89A22sYP0dXBX/h9KnAfGEn1uyOuHgi4rnU9OG9rN62LWA1sUkQv3KDW7muS+asHp45w9h8sB+gdR4Q3aPPcjEajQXQGqDvtuh9D/QbE+0zGI/VSTLjPradO8gHfi9sHNIY7x9GW/bdNHuQvn5QpiayHviVRuRp8xaRT/XXCeToLY2wbHPzFoxVKLd4um5Ytlxl2TS0R2hudMYoNthfzfNe99ch4TIj1MGXirIpOIddRPS70TvSgCph9CAdPAPRUG5xbR+zECxl+f41aj0CzkeJxJetyHP2/yZXUvw3ddPIaQcNpW5Fuy2jeSz0Tr5ptU3/iH5XvXhA6ucBAqUJJSJoIcxoFkSQ8XDiwLUSty7G6e6PBJKOBJVZS78pBKlxJuhtkssyhG+w1Sjx42QnEM6dgsjZgv3R9f3kTUQ7YKxQZop9++ct8NOVPdX42mA1WV9YOTEWfM84FiQLayJKnBxR8MHmSSFGJSG5K+OwOUIWfPDkv64+Q== abs@holystone" ];
  };
}
