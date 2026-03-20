# nixos

NixOS desktop configuration for Abrar Habib.

## Repo layout

```
nixos/
├── flake.nix               # Flake inputs and host definitions
├── hosts/
│   ├── nixos/              # Main desktop host (active)
│   ├── hyprland/           # Hyprland WM host
│   ├── plasma-six/         # KDE Plasma 6 host
│   └── ...
└── modules/
    └── desktop/
        ├── plasma6.nix     # KDE Plasma 6 desktop module
        └── hyprland.nix    # Hyprland desktop module
```

## Three-repo setup

| Repo | Purpose |
|------|---------|
| **nixos** (this repo) | NixOS system configuration for the desktop |
| **[home-manager](https://github.com/dddictionary/home-manager)** | Personal home-manager config (shell, tools, packages) |
| **dotnix** (private) | Work-specific config layered on top of home-manager |

The home-manager config is managed independently and applied separately via `switch-home`.

## Commands

### First-time setup on a new NixOS machine

```bash
# 1. Clone repos
git clone https://github.com/dddictionary/nixos ~/nixos
git clone https://github.com/dddictionary/home-manager ~/home-manager

# 2. Apply NixOS system config
sudo nixos-rebuild switch --flake ~/nixos/#nixos

# 3. Apply home-manager config (opens a new shell with the alias available)
home-manager switch --flake ~/home-manager#linux
```

### Day-to-day

```bash
switch-nix   # sudo nixos-rebuild switch --flake ~/nixos/#nixos
switch-home  # home-manager switch --flake ~/home-manager#linux
switch-both  # runs both in sequence
```

### Switching hosts

```bash
sudo nixos-rebuild switch --flake ~/nixos/#hyprland
sudo nixos-rebuild switch --flake ~/nixos/#plasma-six
```
