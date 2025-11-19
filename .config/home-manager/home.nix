{ config, pkgs, ... }:

{
  home.username = "rejin";
  home.homeDirectory = "/home/rejin";
  home.stateVersion = "25.05";

  # User packages - REMOVED 'git' from here
  home.packages = with pkgs; [
    vim
    wget
    alacritty
    fuzzel
    mako
    neovim
    wl-clipboard
    cliphist
    wl-clip-persist
    telegram-desktop
    catppuccin-cursors
    phinger-cursors
    appflowy
    # git  <- REMOVE THIS LINE (it's already installed via programs.git)
    tree
    stow
  ];

  # Git configuration - This installs gitFull
  programs.git = {
    enable = true;
    package = pkgs.gitFull;  # This provides git already
    userName = "rejin-btw";
    userEmail = "rejinks@zohomail.in";
    extraConfig = {
      credential.helper = "libsecret";
      core.editor = "vim";
    };
  };

  programs.firefox = {
    enable = true;
  };

  # Dotfile management with correct absolute paths
  home.file = {
    ".config/niri".source = /home/rejin/dotfiles/.config/niri;
    ".config/mako".source = /home/rejin/dotfiles/.config/mako;
    ".config/fuzzel".source = /home/rejin/dotfiles/.config/fuzzel;
    "scripts".source = /home/rejin/dotfiles/scripts;
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}

