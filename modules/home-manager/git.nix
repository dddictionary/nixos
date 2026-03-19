{ config, lib, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Abrar Habib";
      user.email = "abrarhabib285@gmail.com";

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        undo = "reset HEAD~1 --mixed";
        amend = "commit -a --amend";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d";
        diffmain = "!f() { git diff main \"$@\"; }; f";
        changed = "diff --name-only main";
        edit = ''!git diff --name-only main | xargs ''${EDITOR:-vim}'';
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.excludesfile = "${config.home.homeDirectory}/.gitignore_global";
      core.pager = "delta";
      http.postBuffer = 524288000;
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
}
