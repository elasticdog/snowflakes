{
  wayland.windowManager.sway = {
    enable = true;

    config.input = {
      * = {
        xkb_options = "altwin:prtsc_rwin,ctrl:nocaps,shift:both_capslock";
      };
    };

    config.terminal = "kitty";
  };
}
