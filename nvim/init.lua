vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- -- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.lazy")

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "nvim-telescope/telescope.nvim",
    tag ='0.1.5',
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }, 
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   }
  -- }
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

        -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
        -- configuration goes here
    },
  }, 
}
local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', function() builtin.find_files({
  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
}) end, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
require("telescope").load_extension "file_browser"
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "lua", "typescript", "json", "javascript", "python", "terraform" },
  highlight = { enable = true },
  indent = { enable = true }
})

-- require("nvim-tree").setup {}
-- require("nvim-tree").setup({
--   sort = {
--     sorter = "case_sensitive",
--   },
--   view = {
--     width = 30,
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = false,
--   },
-- })
-- require("oil").setup({
--   default_file_explorer = true,
--   delete_to_trash = true,
--   view_options = {
--     -- Show files and directories that start with "."
--     show_hidden = true,
--     -- This function defines what is considered a "hidden" file
--     is_hidden_file = function(name, bufnr)
--       return vim.startswith(name, ".")
--     end,
--     -- This function defines what will never be shown, even when `show_hidden` is set
--     is_always_hidden = function(name, bufnr)
--       return false
--     end,
--     sort = {
--       -- sort order can be "asc" or "desc"
--       -- see :help oil-columns to see which columns are sortable
--       { "type", "asc" },
--       { "name", "asc" },
--     },
--   }
-- })

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
