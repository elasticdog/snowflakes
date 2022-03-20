{
  # screen backlight control
  hardware.brillo.enable = true;

  # what to do when the laptop lid is closed
  # or the power button is short-pressed
  services.logind = {
    lidSwitch = "suspend";
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };
}
