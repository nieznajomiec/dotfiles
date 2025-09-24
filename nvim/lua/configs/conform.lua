local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    formatters_by_ft = {
      go = { "goimports", "gofmt" },  -- Форматеры для Go (goimports добавляет импорты)
    },
    -- format_on_save = false,  -- Включите true для автоформатинга при сохранении

    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
