{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    # localVariables = { POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true; };
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      switch-home = "home-manager switch --flake ~/nixos/";
      switch-nix = "sudo nixos-rebuild switch --flake ~/nixos/#plasma";
      # update = "home-manager switch --flake ~/nixos/";
    };
    initExtra = ''
    [[ ! -f ~/nixos/modules/home-manager/shells/p10k-config/p10k.zsh ]] || source ~/nixos/modules/home-manager/shells/p10k-config/p10k.zsh'';
    history.size = 10000;
    history.path = "$HOME/.zsh_history";
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    #   {
    #     name = "powerlevel10k-config";
    #     src = ./p10k-config;
    #     file = "p10k.zsh";
    #   }
    # ];

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-autosuggestions";
        }
        {
          name = "zsh-users/zsh-syntax-highlighting";
        }
        {
          name = "zsh-users/zsh-completions";
        }
        {
          name = "romkatv/powerlevel10k"; tags=[ as:theme depth:1];
        }
      ];
    };
  };
}
