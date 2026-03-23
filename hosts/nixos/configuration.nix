{
  config,
  pkgs,
  pkgs-unstable,
  hyprland ? null,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # Desktop environment — uncomment one:
    # ../../modules/desktop/plasma6.nix
    ../../modules/desktop/hyprland.nix
  ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = false;
      extraEntries = ''
        menuentry "Arch Linux" --class arch {
          search --fs-uuid --no-floppy --set=root FBFE-E5C6
          chainloader /EFI/GRUB/grubx64.efi
        }
        menuentry "Windows" --class windows {
          search --fs-uuid --no-floppy --set=root 1E9E-D1AB
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.download-buffer-size = 524288000;
  nix.settings.trusted-users = ["root" "abrar"];
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    dates = "weekly";
  };

  # For Windows Time Compatibility
  time.hardwareClockInLocalTime = true;
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.abrar = {
    isNormalUser = true;
    description = "abrar";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
    ];
  };

  # Emacs client
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # NVIDIA GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    wget
    zsh
    git
    xdg-desktop-portal-gtk
    python3
    rustup
    gcc
    clang
    pkg-config-unwrapped
    openssl
    libressl
    man-pages
    man-pages-posix
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    plemoljp-nf
    ibm-plex
    nerd-fonts.blex-mono
  ];

  environment.shells = with pkgs; [zsh];
  users.users.abrar.shell = pkgs.zsh;
  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
