-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme as Nord-Vim 
  use 'shaunsingh/nord.nvim'

  -- Bufferline, for tabs
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  -- File explorer
  -- NOTE: Implement this further down the line, right now a bit lazy
  --use {
  --    'nvim-tree/nvim-tree.lua',
  --    requires = {
  --        'nvim-tree/nvim-web-devicons', -- optional, for file icons
  --    },
  --    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  --}

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('mbbill/undotree')

  -- Git assistance
  use('tpope/vim-fugitive')

  -- LSP
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use('nvim-lua/completion-nvim')

  -- Bracket pairs
  use('jiangmiao/auto-pairs')

  -- pep8 indentation for python
  use('Vimjas/vim-python-pep8-indent')

  -- Noice
  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    }
  })

  -- nvim-tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

end)
