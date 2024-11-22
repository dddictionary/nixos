{ config, pkgs, lib, nixvim, ... }:

{
  programs.nixvim = {
    enable = true;
    package = nixvim;
    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    plugins.lightline.enable = true;

    colorschemes.gruvbox.enable = true;
  };
}