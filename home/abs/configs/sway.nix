{ config, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      input = {
        "*" = { xkb_options = "altwin:prtsc_rwin,ctrl:nocaps,shift:both_capslock"; };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86MonBrightnessDown" = "exec /run/current-system/sw/bin/brillo -q -U 8";
          "XF86MonBrightnessUp" = "exec /run/current-system/sw/bin/brillo -q -A 10";
          "Shift+XF86MonBrightnessDown" = "exec /run/current-system/sw/bin/brillo -u 100000 -q -S 0";
          "Shift+XF86MonBrightnessUp" = "exec /run/current-system/sw/bin/brillo -u 100000 -q -S 100";
        };

      modifier = "Mod4"; # Super
      terminal = "kitty";
    };
  };
}
