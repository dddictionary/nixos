{ config, pkgs, pkgs-unstable, lib, ... }:
let 
    inherit (config.nixvim) helpers;
    neovim-unwrapped = pkgs-unstable.neovim-unwrapped.overrideAttrs (old: {
    meta = old.meta or { } // {
      maintainers = [ ];
    };
  });
in {
  programs.nixvim = {
    enable = true;
    package = neovim-unwrapped;

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
    vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, {})
    vim.keymap.set('n', '<leader>ps', function() require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep > \")}) end)
    ";
    

    # remappings
    globals.mapleader = " ";

    keymaps = [
    {
      key = "M";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      options = {
        # silent = true;
      };
    }
    {
      key = "<leader>ff";
      action = "<cmd>Ex<CR>";
    } 
    {
      key = "<C-j>";
      action = "<Esc>";
    } 
    ];

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    luaLoader.enable = true;
    plugins = {

      harpoon = {
	enable = true;
	enableTelescope = true;

# vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
# vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
# vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
# vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end)
# vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end)
# vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end)
# -- Toggle previous & next buffers stored within Harpoon list
# vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
# vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)
	keymaps = {
	    addFile = "<leader>a";
	    toggleQuickMenu = "<C-e>";
	    gotoTerminal = {
		"1" = "<C-j>";
		"2" = "<C-k>";
		"3" = "<C-l>";
		"4" = "<C-m>";
	    };
	    navNext = "<C-S-N>";
	    navPrev = "<C-S-P>";
	};	
    };

      render-markdown.enable = true;
      auto-save.enable = true;
      web-devicons.enable = true;
      neocord.enable = true;
      rustaceanvim = {
	enable = true;
      };

      lualine.enable = true;
      cmp-nvim-lsp.enable = true;
      telescope = {
	enable = true;
      };

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
	inlayHints = true;
        servers = {
          lua_ls.enable = true;
          
          ts_ls.enable = true;
          clangd.enable = true;
	  pyright.enable = true;
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
