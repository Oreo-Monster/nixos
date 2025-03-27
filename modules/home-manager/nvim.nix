{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  config = {
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
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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
