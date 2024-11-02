{ config, pkgs, lib, ... }:


{
	programs.emacs = {
		enable = true;
		package = pkgs.emacs;
		extraConfig = builtins.readFile ./.emacs;
	};
}
