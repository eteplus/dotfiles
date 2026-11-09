-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

if vim.g.vscode then
  keymap.set({ "n", "v" }, "gcc", [[<cmd>call VSCodeNotify('editor.action.commentLine')<cr>]], { silent = true })
  -- keymap.set({ "n", "v", "x" }, "<space>", [[<cmd>call VSCodeNotify('whichkey.show')<cr>]], { silent = true })
  keymap.set("n", "u", [[<cmd>call VSCodeNotify('undo')<cr>]], { silent = true })
  keymap.set("n", "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })
  keymap.set("n", "<leader>fr", [[<cmd>call VSCodeNotify('copyRelativeFilePath')<cr>]], { silent = true })
  keymap.set("n", "<leader>fa", [[<cmd>call VSCodeNotify('copyFilePath')<cr>]], { silent = true })
end

-- Copy file paths to the system clipboard
local function copy_path(expr, label)
  return function()
    local path = vim.fn.expand(expr)
    vim.fn.setreg("+", path)
    vim.notify(("Copied %s: %s"):format(label, path), vim.log.levels.INFO)
  end
end

keymap.set("n", "<leader>fr", copy_path("%:p:.", "relative path"), { desc = "Copy Relative Path" })
keymap.set("n", "<leader>fa", copy_path("%:p", "absolute path"), { desc = "Copy Absolute Path" })
keymap.set("n", "<leader>fn", copy_path("%:t", "file name"), { desc = "Copy File Name" })

keymap.set("i", "<C-【>", "<Esc>", { noremap = true, silent = true })
