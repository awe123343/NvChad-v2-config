local servers = {
  "lua_ls",
}

local function idxOf(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end

local data_exists, custom_lsp = pcall(require, "core.config")
if data_exists then
  for _, client in pairs(custom_lsp.mason_ensure_installed) do
    table.insert(servers, client)
  end
end

local unregis_lsp = {}
local data_ok, unregis = pcall(require, "core.config")
if data_ok then
  if unregis.unregister_lsp ~= nil then
    unregis_lsp = unregis.unregister_lsp
  end
end

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

require("mason-lspconfig").setup_handlers {
  function(server_name) -- default handler (optional)
    local is_skip = false
    local my_index = idxOf(unregis_lsp, server_name)
    if my_index ~= nil then
      is_skip = true
    end
    if not is_skip then
      opts = {
        on_attach = require("custom.configs.lsp.handlers").on_attach,
        capabilities = require("custom.configs.lsp.handlers").capabilities,
      }

      server_name = vim.split(server_name, "@")[1]

      local require_ok, conf_opts = pcall(require, "custom.configs.lsp.settings." .. server_name)
      if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
      end
      lspconfig[server_name].setup(opts)
    end
  end,
}
