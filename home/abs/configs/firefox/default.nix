{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg.enableTridactylNative = true;
    };

    profiles = {
      work = {
        id = 0;
        isDefault = true;
        bookmarks = {
          aws = {
            keyword = "aws";
            name = "Amazon Web Services (AWS) management console";
            url = "https://elastic-prod.signin.aws.amazon.com/console";
          };
          gcp = {
            keyword = "gcp";
            name = "Google Cloud Platform (GCP) management console";
            url = "https://console.cloud.google.com/";
          };
          github = {
            keyword = "gh";
            name = "GitHub - Elastic";
            url = "https://github.com/elastic/";
          };
        };
      };

      home = {
        id = 1;
        bookmarks = {
          hackernews = {
            keyword = "hn";
            name = "Hacker News";
            url = "https://news.ycombinator.com/";
          };
          lobsters = {
            keyword = "l";
            name = "Lobsters";
            url = "https://lobste.rs/";
          };
          pinboard = {
            keyword = "pb";
            name = "Pinboard";
            url = "https://pinboard.in/";
          };
        };
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
        exec = "firefox -P ${profile} %U";
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
