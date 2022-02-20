{
  # screen backlight control
  hardware.brillo.enable = true;

  # system-level keyboard shortcut daemon
  #
  #     $ sudo actkbd --noexec --showkey --device <device>
  #
  # /dev/input/event0 = "AT Translated Set 2 keyboard"
  #
  #   keys  56 = Alt_L
  #   keys 100 = Alt_R
  #   keys 113 = XF86AudioMute
  #   keys 114 = XF86AudioLowerVolume
  #   keys 115 = XF86AudioRaiseVolume
  #
  # /dev/input/event5 = "Video Bus"
  #
  #   keys 224 = XF86MonBrightnessDown
  #   keys 225 = XF86MonBrightnessUp
  #
  # /dev/input/event10 "ThinkPad Extra Buttons"
  #
  #   keys 190 = XF86AudioMicMute
  #   keys 227 = XF86Display
  #   keys 238 = XF86WLAN
  #   keys 444 = XF86NotificationCenter
  #   keys 445 = XF86PickupPhone
  #   keys 446 = XF86HangupPhone
  #   keys 156 = XF86Favorites
  services.actkbd = {
    enable = true;
    bindings = [
      # XF86MonBrightnessDown
      { keys = [ 224 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/brillo -q -U 8 &"; }
      { keys = [ 224 56 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brillo -u 1500000 -q -S 0 &"; }
      { keys = [ 224 100 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brillo -u 1500000 -q -S 0 &"; }

      # XF86MonBrightnessUp
      { keys = [ 225 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/brillo -q -A 10 &"; }
      { keys = [ 225 56 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brillo -u 1500000 -q -S 100 &"; }
      { keys = [ 225 100 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brillo -u 1500000 -q -S 100 &"; }
    ];
  };
}
