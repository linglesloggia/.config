-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Add lazy.nvim to runtime path
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({

  -- Treesitter for Python syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "python" },
        highlight = { enable = true },
      }
    end
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<A-i>", "copilot#Accept('<CR>')", { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<A-b>", "copilot#Dismiss()", { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<A-l>", "copilot#Next()", { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<A-h>", "copilot#Previous()", { silent = true, expr = true }) 
    end  
  },

  -- Python LSP with pyright
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
    end
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {}
      vim.api.nvim_set_keymap("n", "<A-f>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<A-g>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
    end
  },

})
