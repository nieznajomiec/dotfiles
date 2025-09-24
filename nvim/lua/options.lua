require "nvchad.options"

-- add yours here!

-- local o = vim.o

local opt = vim.opt

-- Мышь
opt.mouse = "a"
-- opt.cursorlineopt ='both' -- to enable cursorline!


-- Табы → пробелы
--opt.expandtab = false 
--opt.tabstop = 4
--opt.shiftwidth = 4
--opt.softtabstop = 4
--opt.smartindent = true
--opt.autoindent = true
--
-- Исключение для Go-файлов: использовать табы шириной 8, не заменять на пробелы
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        opt.tabstop = 8
        opt.shiftwidth = 0 
        opt.expandtab = false 
        opt.softtabstop = 0
        -- Можно оставить smartindent и autoindent как есть (глобально), или переопределить, если нужно:
        opt.smartindent = true
        opt.autoindent = true
    end,
})

