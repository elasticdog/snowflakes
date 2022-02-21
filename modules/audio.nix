{
  # realtime scheduling priority for user processes
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    # compatibility layers
    alsa.enable = true;
    pulse.enable = true;

    # session manager
    media-session.enable = false;
    wireplumber.enable = true;
  };
}
