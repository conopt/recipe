{ config, pkgs, ... }:

let
  nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-web-devicons";
    src = pkgs.fetchFromGitHub {
      owner = "kyazdani42";
      repo = "nvim-web-devicons";
      rev = "2d02a56189e2bde11edd4712fea16f08a6656944";
      sha256 = "sha256-+t6EVhQ7iC9BZOtVeQwrzkmpmUtc/WWBcUohoX4/+Tg";
    };
  };
  tabline-framework = pkgs.vimUtils.buildVimPlugin {
    name = "tabline-framework";
    src = pkgs.fetchFromGitHub {
      owner = "rafcamlet";
      repo = "tabline-framework.nvim";
      rev = "fc388232a38c2ff0e5a7f8840371301d2fd89606";
      sha256 = "sha256-Qhy21i4rv/l5vm+tztPGy+Z7UUc+7vVhBqlfQcpesBQ=";
    };
  };
  nvim-treesitter = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treesitter";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "f53a5a6471994693e7e550b29627ca73d91e0536";
      sha256 = "sha256-FebRBPX4lpLw6Tj7wYiVUpzejAkK3tU1JQIc+6icSMo";
    };
  };
  lualine = pkgs.vimUtils.buildVimPlugin {
    name = "lualine";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "3cf45404d4ab5e3b5da283877f57b676cb78d41d";
      sha256 = "sha256-e0lnaUcwaZVhQfQMXL1HnO9Ds+Qh8She9DtVfsdpEMg";
    };
    buildPhase = ":";
  };
  nvim-tree = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-tree";
    src = pkgs.fetchFromGitHub {
      owner = "kyazdani42";
      repo = "nvim-tree.lua";
      rev = "3e49d9b7484e21f0b24ebdf21b8b7af227ea97a6";
      sha256 = "sha256-pqnpt7wccGF5u+V6qvva+vCLugoi+jJY7rk0lXTzg20";
    };
  };
  hop = pkgs.vimUtils.buildVimPlugin {
    name = "hop";
    src = pkgs.fetchFromGitHub {
      owner = "phaazon";
      repo = "hop.nvim";
      rev = "v2.0.2";
      sha256 = "sha256-rHoHSv5K/4Zb8friFtQGo562Avan2wmExm+SEztDF7k";
    };
  };
  telescope = pkgs.vimUtils.buildVimPlugin {
    name = "telescope";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "0.1.0";
      sha256 = "sha256-cRd0l4K+23eYADH3BCzliwwOY5iY/VFcZMvjUV+0lzc";
    };
    buildPhase = ":";
  };
  plenary = pkgs.vimUtils.buildVimPlugin {
    name = "plenary";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "4b66054e75356ac0b909bbfee9c682e703f535c2";
      sha256 = "sha256-qIfsQScKdwrVXUYry+RDjoMoKLuhlsw1GHOVoeOphfo=";
    };
    buildPhase = ":";
  };
  ruby = pkgs.ruby.withPackages (ps: with ps; [pry]);
in
{
  home.username = "Dolphin";
  home.homeDirectory = "/Users/Dolphin";

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.wget
    pkgs.git
    pkgs.htop
    pkgs.ripgrep
    pkgs.fd
    pkgs.any-nix-shell
    (pkgs.nerdfonts.override { fonts = [ "FiraMono" "SourceCodePro" ]; })
    ruby
  ];

  home.file.".hammerspoon/init.lua".source = ./hammerspoon-init.lua;

  home.file."Library/Rime" = {
    source = ./rime;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    HMC = "~/.config/nixpkgs/home.nix";
  };

  programs.zsh = {
    enable = true;

    # enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;
      theme = "bureau";
    };

    shellAliases = {
      recipe = "git --git-dir=$HOME/.recipe/ --work-tree=$HOME";
      gst = "git status";
      gco = "git checkout";
      glo = "git log --oneline";
      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gcam = "git commit -a -m";
      gcan = "git commit -a --amend --no-edit";
      gd = "git diff";
      v = "nvim";
    };

    initExtra = ''
      any-nix-shell zsh --info-right | source /dev/stdin
    '';
  };

  programs.fzf = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary
      nvim-web-devicons
      tabline-framework
      nvim-treesitter
      papercolor-theme
      hop
      telescope
      # nvim-tree
      lualine
      vim-nix
    ];
    extraConfig = ''
      lua require('_init')
    '';
  };

  xdg.configFile."nvim/lua/_init.lua".source = ./init.lua;

  xdg.configFile.iterm2 = {
    source = ./iterm2;
    recursive = true;
  };

  programs.git = {
    enable = true;
    userEmail = "yakumolx@gmail.com";
    userName = "Bare Bear";
    ignores = [ ".DS_Store" "*.tmp" ];
  };
}
