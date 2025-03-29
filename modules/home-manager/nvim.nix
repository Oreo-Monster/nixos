{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.nvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options = {
    nvim.enable = lib.mkEnableOption "Enable nixvim";

    nvim.treesitter-grammers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        xml
        yaml
        nu
        php
        rust
        vue
        html
        css
      ];
    };
    description = "List of treesitter grammars to be installed";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      vimAlias = true;
      viAlias = true;

      globals.mapleader = " ";
      opts = {
        updatetime = 100;
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        swapfile = false;
        undofile = true;
      };
      colorschemes.nord.enable = true;

      #############################################
      # Key Bindings                              #
      #############################################

      keymaps = [
        {
          mode = "v";
          key = "J";
          action = ":m '>+1<CR>gv=gv";
        }
        {
          mode = "v";
          key = "K";
          action = ":m '<-2<CR>gv=gv";
        }
      ];

      plugins = {
        auto-save.enable = true;
        web-devicons.enable = true;
        vim-css-color.enable = true;
        tmux-navigator.enable = true;

        treesitter = {
          enable = true;
          grammarPackages = cfg.treesitter-grammers;
        };

        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            rust_analyzer = {
              enable = true;
              #Make sure to install Cargo and Rustc elsewhere
              installCargo = false;
              installRustc = false;
            };
            nixd.enable = true;
          };
        };

        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options = {
                desc = "Find Files";
              };
            };
          };
        };
      };
    };
  };
}
