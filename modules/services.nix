{
  services.chrony.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
  };

  services.pipewire.enable = true;
}
