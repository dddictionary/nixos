{config, pkgs, lib, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autoSuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      # update = "home-manager switch --flake ~/nixos/";
    };
    history.size = 10000;
    history.path = "$HOME/.zsh_history";
    # plugins = {

    # };
  };


}
