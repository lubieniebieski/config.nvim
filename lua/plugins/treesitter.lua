return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter", 
    lazy = false,
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "javascript", "html", "ruby" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
  },
}

