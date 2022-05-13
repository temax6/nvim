local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local ret = packer.startup(function(use)
	local plugins = {
		"RRethy/vim-illuminate",
		"akinsho/bufferline.nvim",
		"akinsho/flutter-tools.nvim",
		"akinsho/toggleterm.nvim",
		"bluz71/vim-moonfly-colors",
		"famiu/bufdelete.nvim",
		"folke/trouble.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/nvim-cmp",
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
		"jose-elias-alvarez/null-ls.nvim",
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		"kyazdani42/nvim-tree.lua",
		"kyazdani42/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
		"lewis6991/impatient.nvim",
		"lukas-reineke/indent-blankline.nvim",
		"neovim/nvim-lspconfig",
		"numToStr/Comment.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-lualine/lualine.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
		"p00f/nvim-ts-rainbow",
		"rafamadriz/friendly-snippets",
		"wbthomason/packer.nvim",
        "ggandor/leap.nvim",
	}

	for i in pairs(plugins) do
		use(plugins[i])
	end

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

return ret
