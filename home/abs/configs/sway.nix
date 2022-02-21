{ config, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4"; # Super

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
          xkb_options = "altwin:prtsc_rwin,ctrl:nocaps,shift:both_capslock";
        };
        "type:touchpad" = { tap = "enabled"; natural_scroll = "enabled"; };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioMute" = "exec pamixer --toggle-mute";
          "XF86AudioLowerVolume" = "exec pamixer --decrease 10";
          "XF86AudioRaiseVolume" = "exec pamixer --increase 10";
          "XF86AudioMicMute" = "exec pamixer --source 50 --toggle-mute";
          "XF86MonBrightnessDown" = "exec brillo -q -U 8";
          "XF86MonBrightnessUp" = "exec brillo -q -A 10";
          "Shift+XF86MonBrightnessDown" = "exec brillo -u 100000 -q -S 0";
          "Shift+XF86MonBrightnessUp" = "exec brillo -u 100000 -q -S 100";
        };

      # adjust the size of the mouse cursor
      #seat = { "seat0" = { xcursor_theme = "default 64"; }; };

      terminal = "kitty";
      workspaceAutoBackAndForth = true;
      workspaceLayout = "stacking";
    };
  };
}
