{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "battery" "clock" ];

        "sway/window" = {
          max-length = 50;
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        clock = {
          format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
}
