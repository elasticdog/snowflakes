{
  programs.git = {
    enable = true;
    userEmail = "aaron@elasticdog.com";
    userName = "Aaron Bull Schaefer";

    aliases = {
    };

    # https://github.com/dandavison/delta
    delta.enable = true;

    extraConfig = {
      commit.verbose = true;
      init.defaultBranch = "main";
      push.default = "current";
      remote.pushdefault = "origin";
      user.useConfigOnly = true;
    };

    ignores = [
      ".envrc"
    ];

    includes = [
      {
        condition = "gitdir:~/work/";
        contents = {
          user.email = "abs@elastic.co";
        };
      }
    ];
  };
}
