{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Pakai pkgs dari Home Manager supaya tidak ada instance nixpkgs kedua.
    nixpkgs.useGlobalPackages = true;

    globals = {
      mapleader = ";";
      maplocalleader = "\\";
    };

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;

      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;

      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;

      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      wrap = false;

      updatetime = 250;
      timeoutlen = 300;

      clipboard = "unnamedplus";
      mouse = "a";
      undofile = true;
      swapfile = false;
    };

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
      };
    };
    colorscheme = "tokyonight";

    plugins = {
      lualine.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
      telescope.enable = true;

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          filesystem = {
            follow_current_file.enabled = true;
            filtered_items.visible = true;
          };
        };
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;

        # Parser dipasang lewat Nix (reproducible, tanpa compile saat runtime).
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cpp
          css
          go
          html
          javascript
          json
          lua
          make
          markdown
          nix
          python
          regex
          rust
          toml
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ];
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
    };

    # nvim-lspconfig menyediakan default config; server diaktifkan lewat modul lsp.
    plugins.lspconfig.enable = true;

    lsp = {
      servers = {
        lua_ls.enable = true;
        nixd.enable = true;
        ts_ls.enable = true;
      };

      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
        {
          key = "<leader>d";
          action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear search highlight";
      }
    ];

    extraPackages = with pkgs; [
      fd
      lazygit
      nixfmt
      ripgrep
      stylua
      wl-clipboard
    ];
  };
}
