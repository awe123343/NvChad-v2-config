local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format.with { filetypes = { "cpp", "c" } },

  -- python
  b.formatting.black,
  b.formatting.isort.with {
    extra_args = { "--profile", "black" },
  },
  -- b.diagnostics.mypy,
  b.diagnostics.ruff,

  -- go
  b.diagnostics.golangci_lint,
  b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
