-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.executable("im-select") then
  local augroup = vim.api.nvim_create_augroup("AutoIMSelect", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
    group = augroup,
    callback = function()
      vim.fn.system("im-select com.apple.keylayout.ABC")
    end,
  })
end
