local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local ret = packer.startup(function(use)
	use("akinsho/bufferline.nvim")
	use("akinsho/toggleterm.nvim")
	use("bluz71/vim-moonfly-colors")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/vim-vsnip")
	use("jose-elias-alvarez/null-ls.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("lewis6991/gitsigns.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("neovim/nvim-lspconfig")
	use("numToStr/Comment.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lualine/lualine.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("rafamadriz/friendly-snippets")
	use("wbthomason/packer.nvim")
	use("windwp/nvim-autopairs")

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

local cfg = require("cfg.cfg")

for k, v in pairs(cfg.setup) do
	require(k).setup(v)
end

for k, v in pairs(cfg.lsp) do
	v.on_attach = on_attach
	v.flags = { debounce_text_changes = 150 }
	require("lspconfig")[k].setup(v)
end

local nls = require("null-ls")
nls.setup({
	sources = (function()
		local r = {}
		for k, v in pairs(cfg.fmt) do
			table.insert(r, nls.builtins.formatting[k].with(v))
		end
		return r
	end)(),

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
		end
	end,
})

return ret
