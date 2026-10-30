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

  -- LazyVim strips the heading icons, which leaves the raw `#` marks visible
  -- and makes the rendered buffer read like source. A blank icon conceals the
  -- marks without drawing anything, and `right` keeps the heading flush left.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        icons = { " " },
        position = "right",
        left_pad = 1,
      },
      -- The default filled circles are loud next to CJK text.
      bullet = {
        icons = { "•", "◦", "▪", "▫" },
      },
      code = {
        -- Inline code follows the fenced-code background instead of Tokyo
        -- Night's terminal-black, so a type list stops reading as a wall of
        -- blue blocks.
        highlight_inline = "RenderMarkdownCode",
      },
      -- Tokyo Night draws table borders in its red/orange accents, so every
      -- table looks like a diagnostic. Keep the grid muted instead.
      pipe_table = {
        head = "NonText",
        row = "NonText",
        preset = "round",
      },
    },
  },
}
