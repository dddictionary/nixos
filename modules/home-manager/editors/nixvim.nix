{ config, pkgs, lib, ... }:
let inherit (config.nixvim) helpers;
in {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    luaLoader.enable = true;
    plugins.lualine.enable = true;

    colorschemes.catppuccin.enable = true;
  };
}
