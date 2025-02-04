vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-sleuth",
  { 
    "lewis6991/gitsigns.nvim", 
    opts = { 
      signs = { 
        add = { text = "+" }, 
        change = { text = "~" }, 
        delete = { text = "_" }, 
        topdelete = { text = "‾" }, 
        changedelete = { text = "~" } 
      } 
    } 
  },
  { 
    "folke/which-key.nvim", 
    event = "VimEnter", 
    opts = { delay = 0 },
    config = function()
      require("which-key").setup {}
      local wk = require("which-key")
      wk.register({
        ["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Encontrar Arquivos" },
        ["<leader>g"] = { "<cmd>Telescope live_grep<cr>", "Busca por Grep" },
        ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Abrir/Fechar Árvore de Arquivos" },
        ["<leader>w"] = { "<cmd>w<CR>", "Salvar" },
        ["<leader>q"] = { "<cmd>q<CR>", "Fechar" },
        ["<leader>t"] = { "<cmd>ToggleTerm direction=float<CR>", "Abrir Terminal" },
        ["<leader>p"] = {
          name = "Projetos",
          f = { "<cmd>Telescope find_files cwd=~/projects<CR>", "Arquivos do Projeto" },
          s = { "<cmd>Telescope live_grep cwd=~/projects<CR>", "Pesquisar no Projeto" },
        },
      })
    end,
  },
  { 
    "nvim-telescope/telescope.nvim", 
    event = "VimEnter", 
    branch = "0.1.x", 
    dependencies = { 
      "nvim-lua/plenary.nvim", 
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make", 
        cond = function() return vim.fn.executable "make" == 1 end 
      }, 
      { "nvim-telescope/telescope-ui-select.nvim" }, 
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } 
    } 
  },
  { 
    "neovim/nvim-lspconfig", 
    dependencies = { 
      { "williamboman/mason.nvim", opts = {} }, 
      "williamboman/mason-lspconfig.nvim", 
      "WhoIsSethDaniel/mason-tool-installer.nvim", 
      { "j-hui/fidget.nvim", opts = {} }, 
      "hrsh7th/cmp-nvim-lsp" 
    } 
  },
  { 
    "hrsh7th/nvim-cmp", 
    event = "InsertEnter", 
    dependencies = { 
      { 
        "L3MON4D3/LuaSnip", 
        build = (function() 
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then 
            return 
          end 
          return "make install_jsregexp" 
        end)() 
      }, 
      "saadparwaiz1/cmp_luasnip", 
      "hrsh7th/cmp-nvim-lsp", 
      "hrsh7th/cmp-path" 
    } 
  },
  {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup {
      style = "deep", -- Estilo: darker, deep, warm, cool ou light
      term_colors = true, 
      ending_tildes = false,
    }
    require("onedark").load()
  end,
  },
  { 
    "folke/todo-comments.nvim", 
    event = "VimEnter", 
    dependencies = { "nvim-lua/plenary.nvim" }, 
    opts = { signs = false } 
  },
  { 
    "akinsho/toggleterm.nvim", 
    event = "VeryLazy", 
    opts = {
      open_mapping = [[<leader>t]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = 80,
        height = 20,
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function()
      require("toggleterm").setup()
    end
  },
  { 
    "echasnovski/mini.nvim", 
    config = function() 
      require("mini.ai").setup { n_lines = 500 }
      require("mini.surround").setup()
      local statusline = require "mini.statusline"
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end 
  },
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate", 
    main = "nvim-treesitter.configs", 
    opts = { 
      ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
      auto_install = true, 
      highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
      indent = { enable = true, disable = { "ruby" } } 
    } 
  },
  { 
    "kyazdani42/nvim-tree.lua", 
    opts = {}, 
    config = function() 
      require("nvim-tree").setup {}
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    end 
  },
  { 
  "akinsho/bufferline.nvim", 
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        separator_style = "slant",
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
      }
    }
    vim.keymap.set("n", "<leader>[", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer anterior" })
    vim.keymap.set("n", "<leader>]", "<cmd>BufferLineCycleNext<CR>", { desc = "Próximo buffer" })
  end
},
{
  "dgagn/diagflow.nvim",
  config = function()
    require("diagflow").setup {
      scope = "line", -- Mostra mensagens de diagnóstico apenas para a linha atual
      enable_in_insert = false, -- Desativa em modo de inserção (opcional)
    }
  end,
},},
 {
  ui = { 
    icons = vim.g.have_nerd_font and {} or { 
      cmd = "⌘", 
      config = "🛠", 
      event = "📅", 
      ft = "📂", 
      init = "⚙", 
      keys = "🗝", 
      plugin = "🔌", 
      runtime = "💻", 
      require = "🌙", 
      source = "📄", 
      start = "🚀", 
      task = "📌", 
      lazy = "💤 " 
    } 
  },
})

