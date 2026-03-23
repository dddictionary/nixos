{ pkgs, hyprland, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = hyprland.packages."${pkgs.system}".hyprland;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    libnotify
    dunst
  ];
}
