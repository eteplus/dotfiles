-- Image viewing via the Kitty graphics protocol. `snacks.nvim` already ships with
-- LazyVim, and its `image` module is just disabled by default; this flips it on.
--
-- `imagemagick` is a hard dependency: snacks runs `magick identify` to size every
-- image before drawing it. Without it the buffer falls back to a
-- "# Image Conversion Failed" markdown page, PNG included. JPG/WebP/GIF/HEIC are
-- converted by the same binary; PDFs additionally need `ghostscript`.

-- Upstream bug: switching away from an image buffer calls `placement.hide()`, but
-- nothing ever calls `placement:show()`, so the placeholder grid stays stripped
-- and the image only comes back after closing and reopening the buffer. `_render`
-- only runs while a window still shows the buffer, so clearing the flag there is safe.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    local placement = require("snacks.image.placement")
    local render = placement._render
    placement._render = function(self, marks)
      self.hidden = false
      return render(self, marks)
    end
  end,
})

return {
  {
    "folke/snacks.nvim",
    opts = {
      image = { enabled = true },
    },
  },
}
