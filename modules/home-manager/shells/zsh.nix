{config, pkgs, lib, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      homecfgswitch = "home-manager switch --flake ~/nixos/";
      nixcfgswitch = "nixos-rebuild switch --flake ~/nixos/#plasma";
      # update = "home-manager switch --flake ~/nixos/";
    };
    history.size = 10000;
    history.path = "$HOME/.zsh_history";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        # "powerlevel10k".file = "~/powerlevel10k/powerlevel10k.zsh-theme"
      ];
      theme = "powerlevel10k/powerlevel10k";
    };
  };


}
