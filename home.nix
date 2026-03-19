{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  # NixOS-specific shell aliases
  programs.zsh.shellAliases = {
    switch-home = "home-manager switch --flake ~/nixos/";
    switch-nix = "sudo nixos-rebuild switch --flake ~/nixos/#nixos";
    switch-both = "switch-home && switch-nix";
  };

  # NixOS desktop packages (personal layer handles CLI tools)
  home.packages =
    (with pkgs; [
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

      # Extra dev tools
      nixfmt-classic
      rustlings
      python311Packages.pygments
      tree
      unzip
      pandoc
      aoc-cli
    ])
    ++ (with pkgs-unstable; [
      postman
      vscode
      ani-cli
      zed-editor
    ]);

  # Spicetify (Spotify theming)
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
    theme = spicePkgs.themes.onepunch;
    colorScheme = "dark";
  };

  # Hyprland window manager
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
