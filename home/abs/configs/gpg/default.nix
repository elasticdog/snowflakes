{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtlSsh = 7200; # 2h
    extraConfig = ''
      max-cache-ttl-ssh 57600
    '';
  };
}
