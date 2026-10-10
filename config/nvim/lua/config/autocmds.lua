-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_user_markdown", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Starting `nvim <dir>` (or `nvim .`) hands the directory to neo-tree, which
-- leaves the original empty buffer behind. It shows up in the bufferline as a
-- phantom `[No Name]` next to the file tree. Unlist it so the bufferline only
-- shows real files. The buffer itself stays alive, so the neo-tree pane keeps
-- its layout and opening a file still works normally.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_user_no_empty_buffer", { clear = true }),
  pattern = "neo-tree",
  once = true,
  callback = function()
    vim.schedule(function()
      local arg = vim.fn.argv(0)
      if arg == "" then
        return
      end
      local stats = vim.uv.fs_stat(arg)
      if not (stats and stats.type == "directory") then
        return
      end
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
          vim.bo[buf].buflisted
          and vim.bo[buf].buftype == ""
          and vim.api.nvim_buf_get_name(buf) == ""
          and vim.api.nvim_buf_line_count(buf) == 1
          and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
        then
          vim.bo[buf].buflisted = false
        end
      end
    end)
  end,
})
