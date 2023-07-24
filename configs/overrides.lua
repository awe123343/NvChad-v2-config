local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "rust",
    "java",
    "kotlin",
    "python",
    "go",
    "sql",
    "json",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    -- rust
    -- "rust-analyzer",
    -- go
    "gopls",
    "gofumpt",
    "goimports-reviser",
    "golangci-lint",
    "golines",
    "delve",
    -- python
    "black",
    "debugpy",
    "isort",
    -- "mypy",
    "ruff",
    "pyright",
    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
