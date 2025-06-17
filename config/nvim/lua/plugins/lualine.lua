return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, LazyVim.lualine.cmp_source("codeium"))
    end,
  },
}
