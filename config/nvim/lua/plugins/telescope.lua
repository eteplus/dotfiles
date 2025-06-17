return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      opts.defaults.file_ignore_patterns = {
        "%.git/",
        "dist/",
        "build/",
        "node_modules/",
        "pnpm%-lock%.yaml",
      }
    end,
  },
}
