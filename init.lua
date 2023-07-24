local opt = vim.opt
local wo = vim.wo

opt.ruler = true

-- opt.shiftwidth = 4
-- opt.tabstop = 4
-- opt.softtabstop = 4

opt.listchars = { tab = "»·", nbsp = "+", trail = "·", extends = "→", precedes = "←" }
opt.list = true

wo.number = true
wo.relativenumber = true

local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

require "custom.configs.format_onsave"

local lpath = vim.fn.stdpath "config" .. "/lua/custom/my-snippets"
vim.g.vscode_snippets_path = lpath
vim.g.snipmate_snippets_path = lpath
