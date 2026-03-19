{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons --git";
      la = "eza -a --icons";
      lt = "eza --tree --icons";
      l = "eza -la --icons --git";
      cd = "z";
      cat = "bat";
      switch-home = "home-manager switch --flake ~/nixos/";
      switch-nix = "sudo nixos-rebuild switch --flake ~/nixos/#nixos";
      switch-both = "switch-home && switch-nix";
    };

    sessionVariables = {
      COMPLETION_WAITING_DOTS = "true";
      ZSH_CUSTOM = "$HOME/.oh-my-zsh/custom";
      DISABLE_AUTO_TITLE = "true";
      ZSH_DISABLE_COMPFIX = "true";
    };

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [
        "fzf"
        "tmux"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      # === Extra completions from nixpkgs ===
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)

      # === Powerlevel10k instant prompt (must be near top) ===
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f ~/nixos/modules/home-manager/shells/p10k-config/p10k.zsh ]] || source ~/nixos/modules/home-manager/shells/p10k-config/p10k.zsh

      # === tw() — Attach to worktree-specific tmux session ===
      tw() {
        if [[ "$PWD" != ''${HOME}/world/* ]]; then
          echo "Not in ~/world directory"
          return 1
        fi

        if ! git rev-parse --show-toplevel &>/dev/null; then
          echo "Not in a git repository"
          return 1
        fi

        local worktree_name=$(git rev-parse --show-toplevel 2>/dev/null | sed 's|.*/trees/\([^/]*\)/.*|\1|')

        if [[ -z "$worktree_name" ]]; then
          echo "Could not extract worktree name from path"
          return 1
        fi

        create_session_with_windows() {
          local session_name=$1
          local working_dir=$2
          tmux new-session -d -s "$session_name" -c "$working_dir"
          tmux new-window -t "$session_name" -c "$working_dir"
          tmux new-window -t "$session_name" -c "$working_dir"
          tmux select-window -t "$session_name:1"
        }

        if [[ -n "$TMUX" ]]; then
          local current_session=$(tmux display-message -p '#S')
          if [[ "$current_session" != "$worktree_name" ]]; then
            if ! tmux has-session -t "$worktree_name" 2>/dev/null; then
              create_session_with_windows "$worktree_name" "$PWD"
            fi
            tmux switch-client -t "$worktree_name"
          else
            echo "Already in worktree session: $worktree_name"
          fi
        else
          if ! tmux has-session -t "$worktree_name" 2>/dev/null; then
            create_session_with_windows "$worktree_name" "$PWD"
            tmux attach-session -t "$worktree_name"
          else
            tmux attach-session -t "$worktree_name"
          fi
        fi
      }

      # === Terminal title: show current directory and running command ===
      function precmd () {
        echo -ne "\033]0;$(print -rD $PWD)\007"
      }
      precmd

      function preexec () {
        print -Pn "\e]0;$(print -rD $PWD) | $1\a"
      }

      # === Source local overrides for per-machine customization ===
      [ -f ~/.zshrc.local ] && source ~/.zshrc.local

      # === Initialize zoxide (must be at the very end) ===
      export _ZO_DOCTOR=0
      eval "$(zoxide init zsh)"
    '';
  };
}
