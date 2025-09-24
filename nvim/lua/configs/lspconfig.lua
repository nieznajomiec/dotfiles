require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

local lspconfig = require("lspconfig")

-- Настройка для Go с gopls
lspconfig.gopls.setup({
  -- Опции для gopls
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,  -- Предупреждения об неиспользуемых параметрах
        unreachable = true,   -- Предупреждения о недостижимом коде
      },
      staticcheck = true,     -- Включить staticcheck (расширенные анализы)
      completeUnimported = true,  -- Автодополнение для неимпортированных пакетов
      usePlaceholders = true,     -- Плейсхолдеры в автодополнении
    },
  },
  -- Функции для привязки (mappings)
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    -- Примеры горячих клавиш (добавьте в mappings.lua, если нужно)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                    -- Подсказки
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)              -- Переход к определению
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)              -- Найти ссылки
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)     -- Действия с кодом
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)          -- Переименование
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)            -- Предыдущая ошибка
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)            -- Следующая ошибка
  end,
})

