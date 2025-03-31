{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.nvf;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options = {
    nvf.enable = lib.mkEnableOption "Enable git with user name and email";
  };

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;

      settings = {
        vim.viAlias = true;
        vim.vimAlias = true;

        vim.globals = {
          mapleader = " ";
        };

        vim.options = {
          shiftwidth = 2;
        };

        vim.keymaps = [
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
          {
            mode = "n";
            key = "<leader>u";
            action = "vim.cmd.UndotreeToggle";
          }
          {
            mode = "";
            key = "<c-k>";
            action = "vim.cmd.wincmd k<CR>";
            silent = true;
          }
          {
            mode = "";
            key = "<c-j>";
            action = "vim.cmd.wincmd j<CR>";
            silent = true;
          }
          {
            mode = "";
            key = "<c-h>";
            action = "vim.cmd.wincmd h<CR>";
            silent = true;
          }
          {
            mode = "";
            key = "<c-l>";
            action = "vim.cmd.wincmd l<CR>";
            silent = true;
          }
        ];

        vim.theme = {
          enable = true;
          name = "nord";
        };

        vim.telescope = {
          enable = true;
          mappings = {
            liveGrep = "<leader>fw";
          };
          setupOpts.defaults = {
            file_ignore_patterns = [
              "node_modules"
              ".git/"
              "vendor/(?!wright)"
            ];
          };
        };

        vim.filetree.neo-tree = {
          enable = true;
        };

        vim.languages = {
          enableTreesitter = true;
          enableLSP = true;

          nix.enable = true;
          rust.enable = true;
        };

        vim.lazy.plugins = {
          undotree = {
            package = pkgs.vimPlugins.undotree;
            lazy = true;
            cmd = ["UndotreeToggle"];
            keys = [
              {
                mode = "n";
                key = "<leader>u";
                action = "vim.cmd.UndotreeToggle";
              }
            ];
          };
        };
        vim.extraPlugins = {
          tmux-navigator = {
            package = pkgs.vimPlugins.vim-tmux-navigator;
          };
        };
      };
    };
  };
}
