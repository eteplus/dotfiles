return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      -- Setup autotag with default options.
      opts = {
        filetypes = { "html", "xml", "tsx", "vue" },
      },
    },
  },
}
