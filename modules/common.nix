{ pkgs, ... }:

{
  imports = [
    ./containers.nix
    ./home-manager.nix
    ./nix.nix
    ./users.nix
    ./vpn.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmpOnTmpfs = true;

  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120
  '';

  # preferred over the default systemd-timesyncd for ntp
  services.chrony.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
  };

  time.timeZone = "UTC";
}
