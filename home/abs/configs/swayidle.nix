{
  services.swayidle =
    let
      lockCommand = "swaylock --daemonize --show-failed-attempts";
    in
    {
      enable = true;

      # wait for swaylock to lock before releasing
      extraArgs = [ "-w" ];

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
          command = "swaymsg 'output * dpms off'";
          resumeCommand = "swaymsg 'output * dpms on'";
        }
      ];
    };
}
