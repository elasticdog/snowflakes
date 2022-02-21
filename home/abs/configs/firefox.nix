{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    profiles = {
      work = {
        id = 0;
        isDefault = true;
      };

      home = {
        id = 1;
      };

      compatibility = {
        id = 2;
      };
    };
  };

  xdg.desktopEntries =
    let
      makeDesktopEntry = profile: {
        name = "Firefox (${profile})";
        genericName = "Web Browser";
        categories = [ "Network" "WebBrowser" ];
        icon = "firefox";
        exec = "firefox --profile ${profile} %U";
        startupNotify = true;
        terminal = false;
        mimeType = [
          "application/vnd.mozilla.xul+xml"
          "application/xhtml+xml"
          "application/x-xpinstall"
          "text/html"
          "text/xml"
          "x-scheme-handler/ftp"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      };
    in
    {
      firefox = (makeDesktopEntry "work");
      firefox-home = (makeDesktopEntry "home");
      firefox-compatibility = (makeDesktopEntry "compatibility");
    };
}
