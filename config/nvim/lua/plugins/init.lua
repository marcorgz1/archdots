return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  { 
    "typicode/bg.nvim", 
    lazy = false 
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
          "   ▄▄▄▄███▄▄▄▄      ▄████████ ▀████    ▐████▀ ",
          "▄██▀▀▀███▀▀▀██▄   ███    ███   ███▌   ████▀   ",
          "███   ███   ███   ███    ███    ███  ▐███     ",
          "███   ███   ███  ▄███▄▄▄▄██▀    ▀███▄███▀     ",
          "███   ███   ███ ▀▀███▀▀▀▀▀      ████▀██▄      ",
          "███   ███   ███ ▀███████████   ▐███  ▀███     ",
          "███   ███   ███   ███    ███  ▄███     ███▄   ",
          "▀█   ███   █▀    ███    ███ ████       ███▄   ",
          "         ███    ███                           "
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("n", "  > New File", "<cmd>ene<CR>"),
            dashboard.button("c", "  > Configuration", "<cmd>edit $MYVIMRC<CR>"),
            dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
        }

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  }

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
