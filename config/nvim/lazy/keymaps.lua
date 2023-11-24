-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
keymap.set("n", "H", "^", { silent = true })
keymap.set("n", "L", "$", { silent = true })

if vim.g.vscode then
  keymap.set("v", "gc", [[<cmd>call VSCodeNotify('editor.action.commentLine')<cr>]], { silent = true })
  keymap.set("n", "gc", [[<cmd>call VSCodeNotify('editor.action.commentLine')<cr>]], { silent = true })
  keymap.set({ "n", "v", "x" }, "<space>", [[<cmd>call VSCodeNotify('whichkey.show')<cr>]], { silent = true })
  keymap.set({ "n", "v", "x" }, "<leader><space>", [[<cmd>call VSCodeNotify('whichkey.show')<cr>]], { silent = true })
  keymap.set("n", "u", [[<cmd>call VSCodeNotify('undo')<cr>]], { silent = true })
end
