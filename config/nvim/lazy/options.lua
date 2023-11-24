-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
if vim.g.vscode then
  vim.g.mapleader = ","
end

if vim.fn.executable("im-select") then
  vim.api.nvim_exec(
    [[
    augroup AutoIMSelect
      autocmd!
      autocmd InsertLeave * :lua vim.fn.system("im-select com.apple.keylayout.ABC")
      autocmd CmdlineLeave * :lua vim.fn.system("im-select com.apple.keylayout.ABC")
    augroup END
  ]],
    false
  )
end
