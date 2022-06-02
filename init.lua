local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- plugin list
packer.startup(function(use)
	for _, plugin in pairs({
		"RRethy/vim-illuminate",
		"akinsho/toggleterm.nvim",
		"bluz71/vim-moonfly-colors",
		"dart-lang/dart-vim-plugin",
		"famiu/bufdelete.nvim",
		"folke/which-key.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/nvim-cmp",
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
		"lewis6991/gitsigns.nvim",
		"lukas-reineke/indent-blankline.nvim",
		"mhartington/formatter.nvim",
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rafamadriz/friendly-snippets",
		"tpope/vim-commentary",
		"tpope/vim-surround",
		"wbthomason/packer.nvim",
		"williamboman/nvim-lsp-installer",
		"windwp/nvim-autopairs",
	}) do
		use(plugin)
	end

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

-- setopts
local o = vim.o

o.backup = false
o.clipboard = "unnamedplus"
o.conceallevel = 0
o.cursorline = true
o.fileencoding = "utf-8"
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.mouse = "a"
o.number = true
o.numberwidth = 4
o.pumheight = 10
o.relativenumber = true
o.scrolloff = 999
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
o.shiftwidth = 4
o.shortmess = vim.o.shortmess .. "c"
o.showmode = false
o.showtabline = 2
o.sidescrolloff = 2
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.statusline = vim.o.statusline .. "%F"
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.timeoutlen = 100
o.title = true
o.undofile = true
o.updatetime = 300
o.wrap = false

vim.diagnostic.config({ virtual_text = false })
vim.g.dart_style_guide = 2
vim.g.vsnip_filetypes = { dart = { "flutter" } }

-- vimscript
vim.cmd([[
    autocmd BufWritePost *.tex silent! !latexmk -pdf && latexmk -c && pkill -HUP mupdf

	syntax on
	filetype plugin indent on
	colorscheme moonfly
	hi StatusLine guibg=bg
	hi StatusLineNC guibg=bg
	hi TabLine guibg=bg
	hi TabLineFill guibg=bg
	hi TabLineSel guibg=bg
]])

-- mapping
local function map(mode, from, to, opts)
	vim.api.nvim_set_keymap(mode, from, to, opts or { silent = true })
end
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- insert
map("i", "jk", "<ESC>")

-- visual
map("v", "<leader>,", "gc")
map("v", "H", "^")
map("v", "L", "$")

-- normal
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-n>", "gt")
map("n", "<C-p>", "gT")
map("n", "<leader>,", "gcc")
map("n", "<leader>Q", ":qa!<CR>")
map("n", "<leader>W", ":w !sudo tee %<CR>")
map("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>c", ":Bd!<CR>")
map("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>f", ":FormatWrite<CR>")
map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>h", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>l", ":noh<CR>")
map("n", "<leader>m", ":messages<CR>")
map("n", "<leader>n", ":tab split<CR>")
map("n", "<leader>pdf", ":silent! !mupdf %:p:r.pdf &<CR>")
map("n", "<leader>ps", ":PackerSync<CR>")
map("n", "<leader>q", ":q!<CR>")
map("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>so", ":so %<CR>")
map("n", "<leader>tb", ":Telescope buffers<CR>")
map("n", "<leader>td", ":Telescope diagnostics<CR>")
map("n", "<leader>tfb", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "<leader>tff", ":Telescope find_files hidden=true<CR>")
map("n", "<leader>tgf", ":Telescope git_files hidden=true<CR>")
map("n", "<leader>tof", ":Telescope oldfiles<CR>")
map("n", "<leader>tt", ":Telescope builtin<CR>")
map("n", "<leader>w", ":w!<CR>")
map("n", "<leader>x", ":tabclose!<CR>")
map("n", "H", "^")
map("n", "J", ":bn<CR>")
map("n", "K", ":bp<CR>")
map("n", "L", "$")
map("n", "M", "'")
map("n", "Y", "y$")

-- plugin implementations
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("nvim-lsp-installer").setup({ automatic_installation = true })
require("which-key").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"dart",
		"go",
		"lua",
		"python",
		"rust",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["<Leader>q"] = require("telescope.actions").close,
			},
		},
	},
})

require("formatter").setup({
	filetype = {
		python = { require("formatter.filetypes.python").autopep8 },
		c = { require("formatter.filetypes.c").clangformat },
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		dart = {
			function()
				return {
					exe = "flutter format",
					stdin = false,
				}
			end,
		},
		go = { require("formatter.filetypes.go").gofumpt },
		rust = { require("formatter.filetypes.rust").rustfmt },
	},
})

require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	insert_mapping = false,
	direction = "float",
})

local cmp = require("cmp")
cmp.setup.cmdline(":", { sources = { { name = "cmdline" } }, mapping = cmp.mapping.preset.cmdline({}) })
cmp.setup.cmdline("/", { sources = { { name = "buffer" } }, mapping = cmp.mapping.preset.cmdline({}) })

cmp.event:on(
	"confirm_done",
	require("nvim-autopairs.completion.cmp").on_confirm_done({
		map_char = { tex = "" },
	})
)

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) ~= 0 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#available"](1) ~= 0 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
			else
				fallback()
			end
		end,
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

-- lsp
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp = require("lspconfig")
local function setup(server, cfg)
	local default_cfg = { capabilities = cmp_capabilities }
	for k, v in pairs(cfg or {}) do
		default_cfg[k] = v
	end
	lsp[server].setup(default_cfg)
end

setup("bashls")
setup("clangd")
setup("dartls", { flags = { debounce_text_changes = 1000 } })
setup("gopls")
setup("pyright")
setup("sumneko_lua", {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				disable = {
					"lowercase-global",
				},
				globals = {
					"vim",
					"on_attach",
					"PACKER_BOOTSTRAP",
					"client",
					"awesome",
					"screen",
					"root",
				},
			},
		},
	},
})
setup("vimls")
