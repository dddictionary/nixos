{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  spicetify-nix,
  nixvim-config,
  system,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  home.username = "abrar";
  home.homeDirectory = "/home/abrar";
  home.stateVersion = "23.11";

  imports = [
    ./modules/home-manager/terminals/kitty.nix
    ./modules/home-manager/terminals/tmux.nix
    ./modules/home-manager/shells/zsh.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/gitignore.nix
    ./modules/home-manager/graphite.nix
    spicetify-nix.homeManagerModules.default
  ];

  home.packages =
    (with pkgs; [
      # CLI tools
      ripgrep
      fd
      fzf
      jq
      bat
      eza
      zoxide
      tmux
      viddy
      glow
      git
      gh
      delta
      btop
      ncdu
      curl
      wget
      httpie
      tree
      unzip
      pandoc
      aoc-cli

      # Fonts
      nerd-fonts.blex-mono

      # Dev
      nodejs_20
      python3
      ruby
      nixfmt-classic
      rustlings
      python311Packages.pygments

      # Desktop apps
      racket
      mpv
      vlc
      (discord-canary.override {
        withOpenASAR = true;
        withVencord = true;
      })
      teams-for-linux
      evince
      neofetch
      vesktop
      zoom-us
      styluslabs-write-bin
      texliveFull
      texstudio
      libreoffice
      obs-studio
      chromium
      gparted
    ])
    ++ (with pkgs-unstable; [
      postman
      vscode
      ani-cli
      zed-editor
    ])
    ++ [ nixvim-config.packages.${system}.default ];

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.editor = "nvim";
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
    theme = spicePkgs.themes.onepunch;
    colorScheme = "dark";
  };

  wayland.windowManager.hyprland = let
    startupScript = pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &

      sleep 1

      ${pkgs.swww}/bin/swww img ./wallpapers/0001.jpg &
      discord &
    '';
  in {
    enable = true;
    settings = {
      exec-once = ''${startupScript}/bin/start'';
      "$mod" = "SUPER";
      bind = [
        "$mod, return, exec, kitty"
        "$mod, F, exec, firefox"
        "$mod, Q, killactive"
        "$mod, R, exec, rofi"
      ];
    };
  };
}
