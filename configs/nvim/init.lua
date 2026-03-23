-- ── Bootstrap lazy.nvim (plugin manager) ────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ── Options ───────────────────────────────────────────────────────────────────
vim.opt.number         = true   -- line numbers
vim.opt.relativenumber = true   -- relative line numbers
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true   -- spaces instead of tabs
vim.opt.wrap           = false
vim.opt.termguicolors  = true
vim.opt.clipboard      = "unnamedplus"  -- use system clipboard

-- ── Keymaps ───────────────────────────────────────────────────────────────────
vim.g.mapleader = " "

local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<cr>")        -- save
map("n", "<leader>q", "<cmd>q<cr>")        -- quit
map("n", "<leader>e", "<cmd>Ex<cr>")       -- file explorer
map("n", "<C-h>", "<C-w>h")               -- navigate splits
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- ── Plugins ───────────────────────────────────────────────────────────────────
require("lazy").setup({
    -- Colorscheme
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({ options = { theme = "tokyonight" } })
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>" },
        },
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "bash", "terraform", "json", "yaml", "markdown" },
                highlight = { enable = true },
            })
        end,
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { "<leader>t", "<cmd>NvimTreeToggle<cr>" } },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    -- Comment toggle
    {
        "numToStr/Comment.nvim",
        keys = { "gc", "gb" },
        config = true,
    },
})
