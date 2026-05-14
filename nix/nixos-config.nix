# =============================================================================
# NixOS VM Configuration
# Provides a reproducible development environment matching the setup described
# in this repository (dark theme, VSCode, Python, Rust, C, Node.js toolchains).
#
# Usage:
#   1. Install Nix: https://nixos.org/download
#   2. Enable flakes: echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
#   3. Apply: nixos-rebuild switch --flake .#ig-dev-vm  (NixOS)
#      or:    nix develop                               (nix-shell-like env)
# =============================================================================

{ config, pkgs, lib, ... }:

{
  imports = [ ];

  # ─── System ────────────────────────────────────────────────────────────────
  system.stateVersion = "24.05";
  time.timeZone       = "UTC";   # Change to your timezone, e.g. "Europe/Istanbul"
  i18n.defaultLocale  = "en_US.UTF-8";

  # ─── Bootloader (QEMU/KVM) ────────────────────────────────────────────────
  boot.loader.grub.enable  = true;
  boot.loader.grub.device  = "nodev";
  boot.loader.grub.efiSupport = true;

  # ─── Networking ────────────────────────────────────────────────────────────
  networking = {
    hostName  = "ig-dev-vm";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
  };

  # ─── Users ─────────────────────────────────────────────────────────────────
  users.users.igdev = {
    isNormalUser   = true;
    description    = "IG Dev User";
    extraGroups    = [ "wheel" "networkmanager" "docker" ];
    shell          = pkgs.zsh;
    # password is managed externally; set with: passwd igdev
  };

  # ─── Enable sudo ───────────────────────────────────────────────────────────
  security.sudo.wheelNeedsPassword = true;

  # ─── Desktop (minimal dark GNOME) ─────────────────────────────────────────
  services.xserver = {
    enable         = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable   = true;
    displayManager.gdm.wayland  = true;
  };
  # Apply dark theme system-wide
  environment.variables.GTK_THEME = "Adwaita:dark";
  programs.dconf.enable = true;
  home-manager.users.igdev = { pkgs, ... }: {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme    = "Adwaita-dark";
      };
    };
  };

  # ─── Packages ─────────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # Core utilities
    git curl wget unzip zip nano
    openssh xclip

    # Shells & prompt
    zsh oh-my-zsh starship

    # Editors
    vscode

    # Browsers
    brave firefox

    # Python toolchain
    python312
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.black
    python312Packages.pytest
    uv
    pyenv

    # Rust toolchain
    rustup

    # C toolchain
    gcc clang cmake clang-tools   # clang-tools includes clang-format

    # Node.js
    nodejs_lts

    # Database tools
    sqlite
    dbeaver-bin                   # DB Browser / universal DB tool

    # File transfer
    filezilla

    # Email
    thunderbird

    # VPN
    protonvpn-gui

    # Communication / Notes
    # notion                      # install via Flatpak (not in nixpkgs)

    # Container / QEMU
    qemu
    docker

    # Git utilities
    git-lfs
    gh                            # GitHub CLI
  ];

  # ─── Shell ─────────────────────────────────────────────────────────────────
  programs.zsh = {
    enable              = true;
    enableCompletion    = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable  = true;
      theme   = "agnoster";
      plugins = [ "git" "pyenv" "rust" "node" "ssh-agent" "colored-man-pages" ];
    };
  };

  # ─── SSH ───────────────────────────────────────────────────────────────────
  services.openssh = {
    enable                  = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin        = "no";
  };

  # ─── Docker ────────────────────────────────────────────────────────────────
  virtualisation.docker.enable = true;

  # ─── VS Code (system-level extensions via home-manager) ───────────────────
  # Extensions are better managed per-user; see vscode/extensions.json
  # and run: cat extensions.json | jq -r '.recommendations[]' | xargs -I{} code --install-extension {}

  # ─── Filesystem Layout ────────────────────────────────────────────────────
  # Create ig_one directory structure on first boot
  system.activationScripts.igDirs = ''
    install -d -m 755 /home/igdev/ig_one/ig_dev
    install -d -m 755 /home/igdev/ig_one/ig_repos
    install -d -m 755 /home/igdev/ig_one/ig_personal
    chown -R igdev:igdev /home/igdev/ig_one
  '';
}
