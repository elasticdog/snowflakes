{
  programs.fish.functions = {
    gcd = {
      description = "Change to the top-level directory of the current Git repository";
      body = ''
        if set top_level (command git rev-parse --show-toplevel)
            cd "$top_level/$argv[1]"
        else
            return 1
        end
      '';
    };
  };
}
