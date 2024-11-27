{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark Hard";
		font.name = "IBM Plex Mono";
    font.package = pkgs.ibm-plex;
    font.size = 13.5;
    shellIntegration.enableZshIntegration = true;
    settings = {
      # font_family = "IBM Plex Mono Thin";
      # font_size = 13;
      background_opacity = "0.95";
      cursor_shape = "beam";
      open_url_with = "firefox";
      detect_urls = true;
      dynamic_background_opacity = true;
      remember_window_size = true;
      initial_window_width = 480;
      initial_window_height = 270;
    };
  };
}
