{ config, pkgs, username, lib, nixvim, ... }:
{
  # Home-manager nixvim configuration
  home-manager.users.${username} = {
    imports = [ nixvim.homeManagerModules.nixvim ];
    
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      opts = {
        updatetime = 100;
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        tabstop = 2;
        softtabstop = 2;
        showtabline = 2;
        expandtab = true;
        smartindent = true;
        shiftwidth = 2;
        breakindent = true;
        cursorline = true;
        scrolloff = 8;
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
        foldenable = false;
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          transparent_background = true;
        };
      };

      plugins = {
        lualine.enable = true;
        telescope.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        luasnip.enable = true;
        schemastore.enable = true;
        helm.enable = true;
        tmux-navigator.enable = true;
        friendly-snippets.enable = true;
        comment.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        bufferline.enable = true;
        lsp-format.enable = true;
        nvim-autopairs.enable = true;
        nvim-colorizer.enable = true;
        indent-blankline.enable = true;
        gitsigns.enable = true;
        which-key.enable = true;
        markdown-preview.enable = true;
        surround.enable = true;
        tagbar.enable = true;
        todo-comments.enable = true;
        chadtree.enable = true;
        noice.enable = true;
        notify.enable = true;
        persistence.enable = true;
        toggleterm.enable = true;
        barbecue.enable = true;
        lspkind.enable = true;
        trouble.enable = true;
        fidget.enable = true;
        dressing.enable = true;
        airline.enable = false;
        alpha.enable = true;
        auto-save.enable = true;
        better-escape.enable = true;
        cursorline.enable = true;
        nvim-ufo.enable = true;
        rainbow-delimiters.enable = true;
        illuminate.enable = true;
        diffview.enable = true;
        hop.enable = true;
        mini.enable = true;
        neo-tree.enable = true;
        neogit.enable = true;
        undotree.enable = true;
        vim-surround.enable = true;
        wilder.enable = true;
        ts-autotag.enable = true;
        ts-context-commentstring.enable = true;
        emmet.enable = true;
        refactoring.enable = true;
        spider.enable = true;
        treesitter-context.enable = true;
        treesitter-refactor.enable = true;
        vim-matchup.enable = true;
        leap.enable = true;
        fzf-lua.enable = true;
        lazygit.enable = true;
        gitblame.enable = true;
        gitignore.enable = true;
        gitlinker.enable = true;
        zen-mode.enable = true;
        twilight.enable = true;

        lsp = {
          enable = true;
          servers = {
            bashls.enable = true;
            clangd.enable = true;
            cssls.enable = true;
            gopls.enable = true;
            html.enable = true;
            java_language_server.enable = true;
            jsonls.enable = true;
            nil_ls.enable = true;
            marksman.enable = true;
            pyright.enable = true;
            ruff.enable = true;
            tailwindcss.enable = true;
            ts_ls.enable = true;
            vuels.enable = true;
            yamlls.enable = true;
            zls.enable = true;
            typos_lsp.enable = true;
            sqls.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
          };
        };

        cmp-emoji.enable = true;
        cmp = {
          enable = true;
          settings = {
            autoEnableSources = true;
            experimental.ghost_text = true;
            performance = {
              debounce = 60;
              fetchingTimeout = 200;
              maxViewEntries = 30;
            };
            snippet.expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
            formatting = {
              fields = [ "kind" "abbr" "menu" ];
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "emoji"; }
              {
                name = "buffer";
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                keywordLength = 3;
              }
              {
                name = "path";
                keywordLength = 3;
              }
              {
                name = "luasnip";
                keywordLength = 3;
              }
            ];
            window = {
              completion.border = "solid";
              documentation.border = "solid";
            };
            mapping = {
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-e>" = "cmp.mapping.abort()";
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
            };
          };
        };

        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp-cmdline.enable = true;
        cmp_luasnip.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [
        vim-be-good
        vim-hy
        vim-nix
        {
          plugin = vim-startify;
          config = ''
            let g:startify_lists = [
                  \ { 'type': 'files',     'header': ['   Recent Files'] },
                  \ { 'type': 'sessions',  'header': ['   Sessions'] },
                  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
                  \ ]
          '';
        }
      ];

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
          options.desc = "Toggle Neotree";
        }
        {
          mode = "n";
          key = "<leader>gg";
          action = "<cmd>LazyGit<cr>";
          options.desc = "LazyGit";
        }
      ];
    };
  };
}
