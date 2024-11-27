{ config, pkgs, pkgs-unstable, lib, ... }:
let inherit (config.nixvim) helpers;
in {
  programs.nixvim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPlugins = [
      pkgs-unstable.vimPlugins.hover-nvim
    ];

    extraConfigLua = "require('hover').setup {
      init = function()
	require('hover.providers.lsp')
      end,
      preview_opts = {
	border = 'single'
      },
      preview_window = false,
      title = true,
      mouse_providers = {
	'LSP'
      },
      mouse_delay = 1000
    }
    
    vim.keymap.set('n', 'K', require('hover').hover, {desc = 'hover.nvim'})
    vim.keymap.set('n', 'gK', require('hover').hover_select, {desc = 'hover.nvim (select)'})
    vim.keymap.set('n', '<C-p>', function() require('hover').hover_switch('previous') end, {desc = 'hover.nvim (previous source)'})
    vim.keymap.set('n', '<C-p>', function() require('hover').hover_switch('next') end, {desc = 'hover.nvim (next source)'})
    
    ";

    keymaps = [{
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      key = "M";
      options = {
        # silent = true;
      };
    }];

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    luaLoader.enable = true;
    plugins = {
      lualine.enable = true;
      cmp-nvim-lsp.enable = true;
      telescope.enable = true;

      autoclose = {
        enable = true;
        keys = {
          "(" = {
            escape = false;
            close = true;
            pair = "()";
          };
          "[" = {
            escape = false;
            close = true;
            pair = "[]";
          };
          "{" = {
            escape = false;
            close = true;
            pair = "{}";
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          tsserver.enable = true;
          clangd.enable = true;
        };
      };
      # cmp-clippy.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "path"; }
          {
            name = "buffer";
          }
          # { name = "clangd"; }
          { name = "luasnip"; }
        ];

        settings.snippet = {
          expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };

        settings.mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };

    };

    colorschemes.base16.enable = true;
    colorschemes.base16.colorscheme = "gruvbox-dark-hard";
  };
}
