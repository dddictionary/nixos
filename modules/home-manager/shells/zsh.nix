{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autoSuggestion.enable = true;
    # syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      # update = "home-manager switch --flake ~/nixos/";
    };
    history.size = 10000;
    history.path = "$HOME/.zsh_history";
  };

}
