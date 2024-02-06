-- Set VectorScript files to pascal
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead", "BufEnter" },
    { pattern = { "*.px", "*.vs" }, command = "setfiletype pascal" }
)

-- Enable auto format
vim.api.nvim_create_autocmd({ "BufWritePost" }, { command = "FormatWrite" })

-- Enable auto lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
