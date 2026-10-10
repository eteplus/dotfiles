-- Markdown linting is disabled on purpose.
--
-- The `lazyvim.plugins.extras.lang.markdown` extra wires up two sources of
-- markdown diagnostics, and both are stripped out below:
--
--   1. `markdownlint-cli2` via nvim-lint (and via conform, where it also
--      auto-fixes on save). The Mason package stays installed, it just never
--      runs.
--   2. `marksman`, the markdown LSP. It reports `Link to non-existent
--      document` warnings with no config option to turn them off, so its
--      diagnostics are dropped client-side. The server still attaches, so
--      completion, go-to-definition and workspace symbols keep working.
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
          return formatter ~= "markdownlint-cli2"
        end, opts.formatters_by_ft[ft] or {})
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.marksman = vim.tbl_deep_extend("force", opts.servers.marksman or {}, {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      })
    end,
  },
}
