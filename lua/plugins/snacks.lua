return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
        ADAMO
        ]],
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    git = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    { "<leader>gl",       function() Snacks.lazygit.log_file() end,   desc = "Lazygit Log (cwd)" },
    { "<leader>lg",       function() Snacks.lazygit() end,            desc = "Lazygit" },
    { "<C-p>",            function() Snacks.picker.pick("files") end, desc = "Find Files" },
    { "<leader><leader>", function() Snacks.picker.recent() end,      desc = "Recent Files" },
    { "<leader>fb",       function() Snacks.picker.buffers() end,     desc = "Buffers" },
    { "<leader>fg",       function() Snacks.picker.grep() end,        desc = "Grep Files" },
    { "<C-n>",            function() Snacks.explorer() end,           desc = "Explorer" },
    { "<leader>z",        function() Snacks.zen() end,                desc = "Toggle Zen Mode" },
    { "<leader>Z",        function() Snacks.zen.zoom() end,           desc = "Toggle Zoom" },
  }
}