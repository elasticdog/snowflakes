{ pkgs, ... }:

{
  xdg.configFile.kitty_theme = {
    source = ../colorscheme/kitty.conf;
    target = "kitty/themes/elasticdog.conf";
  };

  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.iosevka;
      name = "Iosevka";
      size = 12;
    };

    extraConfig = ''
      font_features Iosevka +ss04 +cv82
      font_features Iosevka-Extrabold +ss04 +cv82
      font_features Iosevka-Italic +ss04 +cv82
      bold_font Iosevka Extrabold
      italic_font Iosevka Italic
    '';

    settings = {
      allow_remote_control = "yes";
      cursor_text_color = "background";
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      include = "themes/elasticdog.conf";
      scrollback_lines = 10000;
      strip_trailing_spaces = "smart";
      touch_scroll_multiplier = "8.0";
      update_check_interval = 0;
      window_padding_width = "4 6";
    };
  };
}
