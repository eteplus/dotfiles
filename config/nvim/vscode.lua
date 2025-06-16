if not vim.g.vscode then
	return {}
end

local vscode = require("vscode")
vim.notify = vscode.notify

vim.g.mapleader = " "
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard:append("unnamedplus")

if vim.fn.executable("im-select") then
	local augroup = vim.api.nvim_create_augroup("AutoIMSelect", { clear = true })
	vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
		group = augroup,
		callback = function()
			vim.fn.system("im-select com.apple.keylayout.ABC")
		end,
	})
end

-- Keymaps
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- map("n", "H", "^")
-- map("n", "L", "$")
-- map("v", "<S-j>", ":m '>+1<CR>gv=gv")
-- map("v", "<S-k>", ":m '<-2<CR>gv=gv")
map("n", "<leader>fb", function()
	vscode.action("workbench.action.showAllEditorsByMostRecentlyUsed")
end)
map("n", "<leader>ff", function()
	vscode.action("workbench.action.quickOpen")
end)
map("n", "<leader>ft", function()
	vscode.action("workbench.action.quickTextSearch")
end)
map("n", "<leader>fo", function()
	vscode.action("workbench.action.gotoSymbol")
end)
map({ "n", "i", "v" }, "<leader>ci", function()
	vscode.action("editor.action.commentLine")
end)
map("n", "<C-p>", function()
	vscode.call("editor.action.marker.previous")
end)
map("n", "<C-n>", function()
	vscode.call("editor.action.marker.next")
end)
map("n", "g[", function()
	vscode.call("editor.action.marker.prevInFiles")
end)
map("n", "g]", function()
	vscode.call("editor.action.marker.nextInFiles")
end)
map("n", "u", function()
	vscode.call("undo")
end)
map("n", "<C-r>", function()
	vscode.call("redo")
end)
map("n", "<Esc>", function()
	vim.cmd("noh")
end)
