{
  services.chrony.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
  };

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.media-session.enable = false;
  services.pipewire.wireplumber.enable = true;
}
