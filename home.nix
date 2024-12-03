{ config, lib, pkgs, pkgs-unstable, spicetify-nix, nixvim, ... }:
let 
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "abrar";
  home.homeDirectory = "/home/abrar";
  imports = [
    ./modules/home-manager/terminals/kitty.nix
    ./modules/home-manager/shells/zsh.nix
    ./modules/home-manager/editors/emacs.nix
    nixvim.homeManagerModules.nixvim
    ./modules/home-manager/editors/nixvim.nix
    spicetify-nix.homeManagerModules.default
  ];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
  home.packages = (with pkgs; [
    racket
    mpv
    vlc
    hello
    tree
    (discord.override {
      # remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })
    teams-for-linux
    evince
    neofetch
    vesktop
    nixfmt-classic
    # opentabletdriver
    unzip
    # spotify
    zoom-us
    texliveFull
    texstudio
    python311Packages.pygments
    bat
    pandoc
    aoc-cli
    libreoffice
    # emacs
    obs-studio
    ripgrep
    # zsh-powerlevel10k
    # zsh-autocomplete
    # zsh-autosuggestions
    # zsh-syntax-highlighting
  ])

    ++

    (with pkgs-unstable; [
      # minecraft
      postman
      vscode
      ani-cli
      zoxide
      zed-editor
      # arc-browser
    ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/abrar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #   nixpkgs = {
  #     config = {
  #       allowUnfree = true;
  #       allowUnfreePredicate = (_: true);
  #     };
  #   };

  # nixpkgs-unstable = {
  #     config = {
  #       allowUnfree = true;
  #       allowUnfreePredicate = (_: true);
  #     };
  #   };

  programs.git = {
    enable = true;
    userName = "Abrar Habib";
    userEmail = "abrarhabib285@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      # credential.helper = "${pkgs.git.override { withLibsecret = true; } 
      #			}/bin/git-credential-libsecret";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.editor = "nvim";
  };

# This should also be in it's own text file!!
#  programs.spicetify = 
#  # let spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
#  # in
#  {
#      enable = true;
#      enabledExtensions = with spicePkgs.extensions; [
#        shuffle # shuffle+ (special characters are sanitized out of extension names)
#      ];
#      theme = spicePkgs.themes.flow;
#      # colorScheme = "mocha";
#    };

    # should should probably be in it's own separate file

  wayland.windowManager.hyprland =
  let 
    # wallpaper = builtins.path{ path=./wallpapers/0001.jpg; };
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
      
      sleep 1

      ${pkgs.swww}/bin/swww img ./wallpapers/0001.jpg &
      discord &
    '';
  in
  {
   enable  = true;
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
