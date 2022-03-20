{
  services.swayidle =
    let
      lockCommand = "swaylock --daemonize --show-failed-attempts --image ~/.local/share/backgrounds/firewatch-asleep-3840x2160.jpg";
    in
    {
      enable = true;

      events = [
        { event = "before-sleep"; command = "${lockCommand}"; }
        { event = "lock"; command = "${lockCommand}"; }
      ];

      timeouts = [
        {
          timeout = 1200; # 20m
          command = "swaymsg \"output * dpms off\"";
          resumeCommand = "swaymsg \"output * dpms on\"";
        }
        {
          timeout = 1500; # 25m
          command = "${lockCommand}";
        }
        {
          timeout = 1800; # 30m
          command = "sudo --remove-timestamp";
        }
        {
          timeout = 3600; # 60m
          command = "systemctl suspend";
        }
      ];
    };
}
