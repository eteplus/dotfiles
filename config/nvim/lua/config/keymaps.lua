-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

if vim.g.vscode then
  keymap.set({ "n", "v" }, "gcc", [[<cmd>call VSCodeNotify('editor.action.commentLine')<cr>]], { silent = true })
  -- keymap.set({ "n", "v", "x" }, "<space>", [[<cmd>call VSCodeNotify('whichkey.show')<cr>]], { silent = true })
  keymap.set("n", "u", [[<cmd>call VSCodeNotify('undo')<cr>]], { silent = true })
  keymap.set("n", "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })
end

keymap.set("i", "<C-【>", "<Esc>", { noremap = true, silent = true })
