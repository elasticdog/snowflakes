{
  # https://flatpak.org/setup/NixOS

  # for installing a more reliable version of zoom
  services.flatpak.enable = true;

  # configure the central repo of applications
  # ( ends up in /var/lib/flatpak/repo/config )
  #
  #   $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #
  # Note that the directories
  #
  # '/var/lib/flatpak/exports/share'
  # '/home/abs/.local/share/flatpak/exports/share'
  #
  # are not in the search path set by the XDG_DATA_DIRS environment variable, so
  # applications installed by Flatpak may not appear on your desktop until the
  # session is restarted.
  #
  #   $ cat /var/lib/flatpak/repo/config
  #
  # [core]
  # repo_version=1
  # mode=bare-user-only
  # min-free-space-size=500MB
  #
  # [remote "flathub"]
  # url=https://dl.flathub.org/repo/
  # xa.title=Flathub
  # gpg-verify=true
  # gpg-verify-summary=true
  # xa.comment=Central repository of Flatpak applications
  # xa.description=Central repository of Flatpak applications
  # xa.icon=https://dl.flathub.org/repo/logo.svg
  # xa.homepage=https://flathub.org/

  # install the zoom application
  #
  #   $ flatpak install flathub us.zoom.Zoom
  #
  # Looking for matches…
  # Required runtime for us.zoom.Zoom/x86_64/stable (runtime/org.freedesktop.Platform/x86_64/21.08) found in remote flathub
  # Do you want to install it? [Y/n]:
  #
  # us.zoom.Zoom permissions:
  #     ipc                    network                pulseaudio               x11             devices
  #     file access [1]        dbus access [2]        bus ownership [3]        tags [4]
  #
  #     [1] xdg-run/pipewire-0, ~/.zoom:create, ~/Documents/Zoom:create
  #     [2] org.freedesktop.ScreenSaver, org.gnome.Shell
  #     [3] org.kde.*
  #     [4] proprietary
  #
  #
  #         ID                                          Branch         Op        Remote         Download
  #  1.     org.freedesktop.Platform.GL.default         21.08          i         flathub        < 131.2 MB
  #  2.     org.freedesktop.Platform.Locale             21.08          i         flathub        < 325.8 MB (partial)
  #  3.     org.freedesktop.Platform.openh264           2.0            i         flathub          < 1.5 MB
  #  4.     org.freedesktop.Platform                    21.08          i         flathub        < 199.6 MB
  #  5.     us.zoom.Zoom                                stable         i         flathub         < 57.5 MB

  # run the zoom application from the cli
  #
  #   $ flatpak run us.zoom.Zoom

  # config file location:
  #   /home/abs/.var/app/us.zoom.Zoom/config/zoomus.conf
}
