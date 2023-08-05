local overrides = require "custom.configs.overrides"
local icons = require "custom.icons"
-- initial active plugins optional
local active_debug = true
local active_toggleterm = true
local active_visualmulti = false
local active_lspinstaller = false
local active_smartsplit = true
local active_liveserver = false
local active_dressing = false
local active_cmdline = false
local active_coderunner = true
local active_winbar = true
-- default variable
local debug = {}
local liveserver = {}
local visualmulti = {}
local coderunner = {}
local lspinstaller = {}
local smartsplit = {}
local dressing = {}
local winbar = {}
local cmdline = {}
local toggleterm = {}
-- activation
if active_toggleterm then
  toggleterm = {
    {
      "akinsho/toggleterm.nvim",
      cmd = "ToggleTerm",
      event = "BufRead",
      config = function()
        require "custom.configs.toggleterm"
      end,
    },
  }
end
if active_cmdline then
  cmdline = {
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      event = "BufWinEnter",
      opts = {
        messages = {
          enabled = false,
        },
        notify = {
          enabled = true,
        },
        lsp = {
          progress = {
            enabled = true,
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
      },
      keys = {
        {
          "<S-Enter>",
          function()
            require("noice").redirect(vim.fn.getcmdline())
          end,
          mode = "c",
          desc = "Redirect Cmdline",
        },
        {
          "<leader>snl",
          function()
            require("noice").cmd "last"
          end,
          desc = "Noice Last Message",
        },
        {
          "<leader>snh",
          function()
            require("noice").cmd "history"
          end,
          desc = "Noice History",
        },
        {
          "<leader>sna",
          function()
            require("noice").cmd "all"
          end,
          desc = "Noice All",
        },
        {
          "<c-f>",
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll forward",
          mode = { "i", "n", "s" },
        },
        {
          "<c-b>",
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll backward",
          mode = { "i", "n", "s" },
        },
      },
    },
    {
      "hrsh7th/cmp-cmdline",
      event = "VeryLazy",
      config = function()
        local cmp = require "cmp"
        local mapping = {
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        }

        -- Use buffer source for `/`.
        cmp.setup.cmdline("/", {
          preselect = "none",
          completion = {
            completeopt = "menu,preview,menuone,noselect",
          },
          mapping = mapping,
          sources = {
            { name = "buffer" },
          },
          experimental = {
            ghost_text = true,
            native_menu = false,
          },
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(":", {
          preselect = "none",
          completion = {
            completeopt = "menu,preview,menuone,noselect",
          },
          mapping = mapping,
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
          experimental = {
            ghost_text = true,
            native_menu = false,
          },
        })
      end,
    },
  }
end
-- for winbar
if active_winbar then
  winbar = {
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
      event = "BufRead",
      config = function()
        require "custom.configs.breadcrumb"
        require "custom.configs.winbar"
      end,
    },
  }
end
-- for dressing
if active_dressing then
  dressing = {
    {
      "stevearc/dressing.nvim",
      lazy = true,
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.input(...)
        end
      end,
    },
  }
end
-- for smart split
if active_smartsplit then
  smartsplit = {
    {
      "mrjones2014/smart-splits.nvim",
      event = "BufRead",
      config = function()
        require "custom.configs.smartsplit"
      end,
    },
  }
end
-- for lspinstaller
if active_lspinstaller then
  lspinstaller = {
    { "williamboman/nvim-lsp-installer", event = "VeryLazy", lazy = true },
  }
end
-- for coderunner
if active_coderunner then
  coderunner = {
    {
      "CRAG666/code_runner.nvim",
      event = "BufRead",
      -- dependencies = "nvim-lua/plenary.nvim",
      cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
      config = function()
        require "custom.configs.coderunner"
      end,
    },
  }
end
-- for visualmulti
if active_visualmulti then
  visualmulti = {
    { "mg979/vim-visual-multi", event = "BufRead" },
  }
end
-- for liveserver
if active_liveserver then
  liveserver = {
    {
      "manzeloth/live-server",
      cmd = { "LiveServer" },
      event = "BufRead",
      build = "npm install -g live-server",
    },
  }
end
-- for debuging
if active_debug then
  debug = {
    {
      "rcarriga/nvim-dap-ui",
      event = "BufRead",
      dependencies = "mfussenegger/nvim-dap",
      config = function()
        require "custom.configs.dapui"
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      event = "BufRead",
      dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
      config = function()
        require "custom.configs.mason_dap"
      end,
    },
    {
      "mfussenegger/nvim-dap",
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
      },
      config = function(_, opts)
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
      end,
    },
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
      },
      config = function(_, opts)
        require("dap-go").setup(opts)
      end,
    },
  }
end
---@type NvPluginSpec[]
local plugins = {

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = " 󰈞  ",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  -- custom by pojok code
  {
    "goolord/alpha-nvim",
    enabled = false,
    event = "BufWinEnter",
    config = function()
      require "custom.configs.alpha"
    end,
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require "custom.configs.lualine"
  --   end,
  -- },
  { "hrsh7th/cmp-nvim-lsp", event = "BufRead" },
  { "hrsh7th/cmp-buffer", event = "BufRead" },
  { "hrsh7th/cmp-path", event = "BufRead" },
  { "saadparwaiz1/cmp_luasnip", event = "BufRead" },
  { "hrsh7th/cmp-nvim-lua", event = "BufRead" },
  -- for auto close tag
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- key mapping
  {
    "folke/which-key.nvim",
    event = "BufRead",
    config = function()
      dofile(vim.g.base46_cache .. "whichkey")
      require "custom.configs.whichkey"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "custom.configs.lsp"
    end,
  },
  -- for formater linter
  {
    "jayp0521/mason-null-ls.nvim",
    lazy = true,
    dependencies = "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    config = function()
      require "custom.configs.mason-null-ls"
    end,
  },
  -- for live server html,css,js
  liveserver,
  -- for multi cursor select
  visualmulti,
  -- for auto detection file and run code
  coderunner,
  -- override lsp
  -- for install lsp tidak support mason
  lspinstaller,
  -- for popup input
  dressing,
  -- for resize split (CTRL + arrow)
  smartsplit,
  -- for winbar icon
  winbar,
  -- for debuging
  debug,
  -- for cmd line popup
  cmdline,
  toggleterm,
  -- { "neoclide/coc.nvim", branch = "release", event = "BufRead" },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
      crates.show()
      require("core.utils").load_mappings "crates"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java", "kt" },
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  { "rainbowhxch/accelerated-jk.nvim", lazy = false },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    opts = {},
  },
}

return plugins
