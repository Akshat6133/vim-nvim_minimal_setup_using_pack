vim.cmd("source ~/.vim/vimrc")


function Transparent()
  vim.api.nvim_set_hl(0, "Normal",       { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn",   { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr",       { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLine",   { bg = "none" })
end

--vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme slate")
Transparent()

vim.diagnostic.enable(true)

-- =========================
-- C code completion (minimal)
-- =========================

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
  },
})

-- capabilities for completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Native LSP config (NEW way)
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c" }, -- ONLY C
  capabilities = capabilities,
})

-- Enable it
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.diagnostic.enable(true)
  end,
})

--map gl<CR> to open diagnostics in Normal Mode 
vim.keymap.set(
  "n",
  "gl",
  function()
    vim.diagnostic.open_float(0, { scope = "line" })
  end,
  { silent = true }
)

-- =========================
-- Minimal C formatter
-- =========================
vim.keymap.set("n", "<leader>f", function()
  vim.cmd("%!clang-format")
end, { desc = "Format C buffer (clang-format)" })


--enable clipboard while using wayland && wl-clipboard
--set clipboard=unnamedplus

