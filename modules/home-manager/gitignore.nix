{
  home.file.".gitignore_global".text = ''
    # macOS
    .DS_Store
    .AppleDouble
    .LSOverride
    ._*
    .DocumentRevisions-V100
    .fseventsd
    .Spotlight-V100
    .TemporaryItems
    .Trashes
    .VolumeIcon.icns
    .com.apple.timemachine.donotpresent
    .AppleDBs
    .AppleDesktop
    Network Trash Folder
    Temporary Items
    .apdisk

    # Cursor/VSCode settings
    settings.json
    snippets.json
    workspace-settings.json
    extensions/**/workspace
    .cursor/personal-settings.json
    .cursor/personal-keybindings.json
    .cursor/personal-snippets.json
    .cursor/workspace-settings.json
    .cursor/extensions/**/workspace
    .cursor/.DS_Store
    .cursor/shouldUpdate
    .cursor/argv.json
    .cursor/**/*.log
    .cursor/**/*.cache
    .cursor/rules/personal/**/*
    .vscode/settings.json

    # Pull request files
    pull-request.md
    pull-request-guide.md

    # Editor directories and files
    .idea
    *.swp
    *.swo
    *~

    # Nix
    result
    result-*

    # Custom script backups
    .comment_removal_backups/

    # System monitoring
    .atop/
    .sysmonitor/

    # Node
    node_modules/
    npm-debug.log*
    yarn-debug.log*
    yarn-error.log*

    # Python
    __pycache__/
    *.py[cod]
    *$py.class
    .Python
    env/
    venv/
    .env

    # Ruby
    *.gem
    .bundle
    vendor/bundle
  '';
}
