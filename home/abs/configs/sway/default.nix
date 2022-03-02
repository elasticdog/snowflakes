{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;

    config = {
      modifier = "Mod4"; # Super

      floating.criteria = [
        { app_id = "kitty"; title = "^Ephemeral Kakoune$"; } # Tridactyl
        { app_id = "pavucontrol"; }
      ];

      gaps = {
        inner = 25;
        smartBorders = "no_gaps";
        smartGaps = true;
      };

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
          xkb_options = "altwin:prtsc_rwin,ctrl:nocaps,shift:both_capslock";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          pointer_accel = "0.6";
          tap = "enabled";
        };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86Display" = "exec wdisplays";
          "XF86Favorites" = "exec swaylock --daemonize --show-failed-attempts --image ~/.local/share/backgrounds/firewatch-asleep-3840x2160.jpg";
          "Control+Mod1+XF86Favorites" = "exec reboot";
          "Control+Mod4+Mod1+XF86Favorites" = "exec poweroff";
          "${modifier}+0" = "workspace back_and_forth";
          "${modifier}+equal" = "[app_id=\"qalculate-gtk\"] scratchpad show";
        };

      output = {
        "*" = { bg = "~/.local/share/backgrounds/firewatch-awake-3840x2160.jpg stretch"; };
      };

      bars = [ ]; # disable swaybars
      focus.forceWrapping = true;
      fonts.size = 0.0;
      menu = "j4-dmenu-desktop --no-generic --dmenu=\"bemenu --no-overlap --prompt ' ' --ignorecase --list 8 --scrollbar autohide --wrap\"";
      terminal = "kitty --single-instance";
      workspaceAutoBackAndForth = false;
      workspaceLayout = "stacking";
    };

    extraConfig = ''
      bindsym --locked XF86AudioMute exec pamixer --toggle-mute
      bindsym --locked XF86AudioLowerVolume exec pamixer --decrease 10
      bindsym --locked XF86AudioRaiseVolume exec pamixer --increase 10
      bindsym --locked XF86AudioMicMute exec pamixer --default-source --toggle-mute
      bindsym --locked XF86MonBrightnessDown exec brillo -q -U 8
      bindsym --locked XF86MonBrightnessUp exec brillo -q -A 10
      bindsym --locked Shift+XF86MonBrightnessDown exec brillo -u 100000 -q -S 0
      bindsym --locked Shift+XF86MonBrightnessUp exec brillo -u 100000 -q -S 100

      for_window [app_id="firefox" title="^$"] floating enable, border none, move position 18 px 9 px
      for_window [app_id="firefox" title="Sharing Indicator$"] floating enable, sticky enable, border none, move position 1835 px 995 px
      no_focus [app_id="firefox" title="^$"]

      for_window [app_id="qalculate-gtk"] floating enable, resize set 20 ppt, move position 18 px 9 px, move scratchpad, scratchpad show

      for_window [class="zoom" title="^Choose ONE of the audio conference options$"] floating enable
      for_window [class="zoom" title="^(About|Settings)$"] floating enable
      for_window [class="zoom" title="^[zZ]oom"] move container to workspace 9, floating enable
      for_window [class="zoom" title="^Zoom - Licensed Account$"] floating disable
      for_window [class="zoom" title="^Zoom Meeting$"] workspace number 9, floating disable, inhibit_idle open
    '';
  };

  wayland.windowManager.sway.config.seat = {
    "seat0" = { xcursor_theme = "phinger-cursors-light 24"; };
  };

  xsession.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 32;
  };
}
