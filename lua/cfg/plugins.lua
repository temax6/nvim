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
		"akinsho/toggleterm.nvim",
		"bluz71/vim-moonfly-colors",
		"famiu/bufdelete.nvim",
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
		"rmagatti/auto-session",
		"rmagatti/session-lens",
		"wbthomason/packer.nvim",
		-- "windwp/nvim-autopairs",
	}

	for i in pairs(plugins) do
		use(plugins[i])
	end

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

local cfg = require("cfg.cfg")
for k, v in pairs(cfg.setup) do
	require(k).setup(v)
end

local binds = require("cfg.binds")
for k, v in pairs(cfg.lsp) do
	if v.on_attach == nil then
		v.on_attach = binds
	else
		local f = v.on_attach
		v.on_attach = function(client, bufnr)
			binds(client, bufnr)
			f(client, bufnr)
		end
	end
	v.flags = { debounce_text_changes = 150 }
	v.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
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

	-- on_attach = function(client)
	-- 	if client.resolved_capabilities.document_formatting then
	-- 		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
	-- 	end
	-- end,
})

return ret
