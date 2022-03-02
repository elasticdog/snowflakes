{
  programs.fish.functions = {
    fish_prompt.body = ''
      if test -n "$SSH_TTY"
          echo -n (set_color -b D3D4D4)(set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
      end

      echo -n (set_color -b D3D4D4)(set_color 595E64)' '(prompt_pwd)' '

      set_color -o
      if fish_is_root_user
          echo -n (set_color red)'# '
      end
      echo -n (set_color -b normal)(set_color D3D4D4)' '
      set_color normal
    '';
  };
}
