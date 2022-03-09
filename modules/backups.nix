{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.restic ];

  # the following credential files must be created manually and put into place:
  #
  #     /root/.config/restic/gcs-service-account-key.json
  #     /root/.config/restic/repository-password
  #
  #     Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
  #
  services.restic.backups = {
    googleCloudStorage = {
      environmentFile = builtins.toFile "restic.env" ''
        GOOGLE_PROJECT_ID=abs-laptop-backups
        GOOGLE_APPLICATION_CREDENTIALS=/root/.config/restic/gcs-service-account-key.json
      '';
      passwordFile = "/root/.config/restic/repository-password";
      repository = "gs:abs-laptop-backups:/";
      initialize = true;

      paths = [ "/home" ];
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 75"
      ];
      timerConfig = {
        OnCalendar = "daily";
      };
    };
  };
}
