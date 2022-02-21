{
  services.swayidle =
    let
      lockCommand = "swaylock --daemonize --show-failed-attempts";
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
          command = "${lockCommand}";
        }
        {
          timeout = 1500; # 25m
          command = "swaymsg \"output * dpms off\"";
          resumeCommand = "swaymsg \"output * dpms on\"";
        }
        {
          timeout = 1800; # 30m
          command = "sudo --remove-timestamp";
        }
      ];
    };
}
