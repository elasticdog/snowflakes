{ pkgs, ... }:

{
  # dependencies bound to on-click events
  home.packages = with pkgs; [
    pamixer
    pavucontrol
  ];

  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "sway-session.target";
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";

        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-center = [ "sway/mode" ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "battery"
          "clock"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
        };

        "sway/window" = {
          format = "  {}";
          tooltip = false;
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pamixer --toggle-mute";
          on-click-right = "pavucontrol";
          on-scroll-up = "pamixer --decrease 10";
          on-scroll-down = "pamixer --increase 10";
          smooth-scrolling-threshold = 2.0;
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (no ip) ";
          format-disconnected = "disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        cpu = {
          format = "{usage}% ";
        };

        memory = {
          format = "{}% ";
          tooltip-format = "{used:0.1f} GiB used / {total:0.1f} GiB total";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C ";
          tooltip = false;
        };

        backlight = {
          format = "{percent}% ";
          on-scroll-up = "brillo -q -U 8";
          on-scroll-down = "brillo -q -A 10";
          smooth-scrolling-threshold = 2.0;
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];

          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";

          states = {
            warning = 30;
            critical = 5;
          };
        };

        clock = {
          format = "{:%H:%M} ";
          format-alt = "{:%a, %b %d  %H:%M %Z}";
          smooth-scrolling-threshold = 4.0;
          timezones = [ "America/Los_Angeles" "UTC" ];
          today-format = "<b><span bgcolor=\"#E4564999\">{}</span></b>";
          tooltip-format = "<span font_size=\"150%\">{:%Y %B}</span>\n<tt>{calendar}</tt>";
        };
      };
    };
  };
}
