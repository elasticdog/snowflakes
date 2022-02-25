{
  programs.kakoune = {
    enable = true;

    config = {
      autoReload = "yes";

      keyMappings = [
        { mode = "insert"; key = "<c-[>"; effect = "<esc>"; }
      ];

      numberLines = {
        enable = true;
        relative = true;
      };

      showMatching = true;
      tabStop = 4;

      ui = {
        assistant = "none";
      };
    };

    extraConfig = ''
      set-option global autowrap_column 80
      set-option global grepcmd "rg --column --follow"
    '';
  };
}
