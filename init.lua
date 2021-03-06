local function map(mode, from, to, opts)
	vim.api.nvim_set_keymap(mode, from, to, opts or { silent = true })
end

local function imap(from, to, opts)
	map("i", from, to, opts)
end
local function nmap(from, to, opts)
	map("n", from, to, opts)
end
local function vmap(from, to, opts)
	map("v", from, to, opts)
end
local function xmap(from, to, opts)
	map("x", from, to, opts)
end

function NvimFmt()
	if string.match(vim.fn.expand("%", false, false), ".lua") == ".lua" then
		local ln = vim.api.nvim_win_get_cursor(0)
		local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
		local did = false
		local cmd_start = -1
		local sort_start = -1
		for i, line in ipairs(lines) do
			if string.match(line, "-- " .. "sort") == "-- " .. "sort" then
				if sort_start == -1 then
					sort_start = i + 1
				else
					vim.cmd(" :" .. sort_start .. "," .. i - 1 .. "sort")
					sort_start = -1
					did = true
				end
			elseif string.match(line, "-- " .. ":") == "-- " .. ":" then
				if cmd_start == -1 then
					cmd_start = i + 1
				else
					vim.cmd(
						":"
							.. cmd_start
							.. ","
							.. i - 1
							.. string.sub(line, string.find(line, ":") + 1)
					)
					cmd_start = -1
					did = true
				end
			end
		end
		if did then
			vim.cmd(":" .. ln[1])
		end
	end
end

function ToggleScrolloff()
	vim.cmd "let &scrolloff=mscrolloff-&scrolloff"
	vim.cmd "let &sidescrolloff=msidescrolloff-&sidescrolloff"
end

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path, false, false)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require "packer"

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({
				border = "rounded",
			})
		end,
	},
	profile = { enable = true, threshold = 0 },
})

packer.startup(function(use)
	for _, plugin in pairs({
		-- sort
		"RRethy/vim-illuminate",
		"akinsho/flutter-tools.nvim",
		"akinsho/toggleterm.nvim",
		"bluz71/vim-moonfly-colors",
		"crispgm/nvim-tabline",
		"famiu/bufdelete.nvim",
		"folke/lua-dev.nvim",
		"folke/which-key.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/nvim-cmp",
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
		"junegunn/vim-easy-align",
		"kyazdani42/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
		"lewis6991/impatient.nvim",
		"lukas-reineke/indent-blankline.nvim",
		"mhartington/formatter.nvim",
		"neovim/nvim-lspconfig",
		"numToStr/Comment.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-lualine/lualine.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rafamadriz/friendly-snippets",
		"simrat39/rust-tools.nvim",
		"smjonas/inc-rename.nvim",
		"tpope/vim-surround",
		"wbthomason/packer.nvim",
		"williamboman/nvim-lsp-installer",
		"windwp/nvim-autopairs",
		{ "dart-lang/dart-vim-plugin", ft = { "dart" } },
		{ "mfussenegger/nvim-jdtls", ft = { "java" } },
		-- sort
	}) do
		use(plugin)
	end

	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)

vim.g.moonflyTransparent = 1

vim.cmd [[
au BufWritePost *.tex silent! !latexmk -pdf && latexmk -c && pkill -HUP mupdf
au User FormatterPost :lua NvimFmt()
au VimResized * wincmd =
colorscheme moonfly
hi TabLine guibg=bg
hi TabLineFill guibg=bg
hi TabLineSel guibg=bg
]]

-- :
-- sort
vim.o.backup                         = false
vim.o.clipboard                      = "unnamedplus"
vim.o.conceallevel                   = 0
vim.o.cursorline                     = true
vim.o.fileencoding                   = "utf-8"
vim.o.hidden                         = true
vim.o.hlsearch                       = true
vim.o.ignorecase                     = true
vim.o.incsearch                      = true
vim.o.mouse                          = "a"
vim.o.number                         = true
vim.o.numberwidth                    = 4
vim.o.pumheight                      = 10
vim.o.relativenumber                 = true
vim.o.ruler                          = true
vim.o.scrolloff                      = 999
vim.o.sessionoptions                 = vim.o.ssop .. ",winpos,terminal"
vim.o.shiftwidth                     = 4
vim.o.shortmess                      = vim.o.shm .. "c"
vim.o.showmode                       = false
vim.o.showtabline                    = 2
vim.o.sidescrolloff                  = 8
vim.o.signcolumn                     = "yes"
vim.o.smartcase                      = true
vim.o.smartindent                    = true
vim.o.splitbelow                     = true
vim.o.splitright                     = true
vim.o.swapfile                       = false
vim.o.tabstop                        = 4
vim.o.termguicolors                  = true
vim.o.timeoutlen                     = 250
vim.o.title                          = true
vim.o.undofile                       = true
vim.o.updatetime                     = 300
vim.o.wrap                           = false
-- sort

-- sort
vim.diagnostic.config({ virtual_text = false })
vim.g.dart_style_guide               = 2
vim.g.mscrolloff                     = vim.o.scrolloff
vim.g.msidescrolloff                 = vim.o.sidescrolloff
vim.g.vsnip_filetypes                = { dart = { "flutter" } }
-- sort
-- :EasyAlign =

-- :
vim.g.mapleader      = " "
vim.g.localmapleader = " "
-- :EasyAlign =

-- :
-- sort
imap("jk",          "<ESC>")
nmap("<C-h>",       "<C-w>h")
nmap("<C-j>",       "<C-w>j")
nmap("<C-k>",       "<C-w>k")
nmap("<C-l>",       "<C-w>l")
nmap("<C-n>",       ":bn<CR>")
nmap("<C-p>",       ":bp<CR>")
nmap("<leader>,",   "gcc")
nmap("<leader>Q",   ":qa!<CR>")
nmap("<leader>W",   ":w !sudo tee %<CR>")
nmap("<leader>a",   ":lua vim.lsp.buf.code_action()<CR>")
nmap("<leader>b",   ":Telescope buffers<CR>")
nmap("<leader>c",   ":Bd!<CR>")
nmap("<leader>d",   ":lua vim.diagnostic.open_float()<CR>")
nmap("<leader>f",   ":Format<CR>")
nmap("<leader>gd",  [[:lua require "telescope.builtin".lsp_definitions { jump_type = "never" }<CR>]])
nmap("<leader>gf",  ":Telescope git_files hidden=true<CR>")
nmap("<leader>h",   ":lua vim.lsp.buf.hover()<CR>")
nmap("<leader>l",   ":noh<CR>")
nmap("<leader>mk",  ":mksession!<CR>")
nmap("<leader>ms",  ":messages<CR>")
nmap("<leader>n",   ":tab split<CR>")
nmap("<leader>of",  ":Telescope oldfiles<CR>")
nmap("<leader>os",  ":so %<CR>")
nmap("<leader>pdf", ":silent! !mupdf %:p:r.pdf &<CR>")
nmap("<leader>ps",  ":PackerSync<CR>")
nmap("<leader>q",   ":q!<CR>")
nmap("<leader>r",   ":IncRename ")
nmap("<leader>s",   ":lua ToggleScrolloff()<CR>")
nmap("<leader>tb",  ":Telescope current_buffer_fuzzy_find<CR>")
nmap("<leader>td",  ":Telescope diagnostics<CR>")
nmap("<leader>tf",  ":Telescope find_files hidden=true<CR>")
nmap("<leader>tt",  ":Telescope builtin<CR>")
nmap("<leader>w",   ":w!<CR>")
nmap("<leader>x",   ":tabclose!<CR>")
nmap("H",           "^")
nmap("J",           "gt")
nmap("K",           "gT")
nmap("L",           "$")
nmap("M",           "'")
nmap("Y",           "y$")
nmap("ga",          "<Plug>(EasyAlign)")
vmap("<leader>,",   "gc")
vmap("H",           "^")
vmap("L",           "$")
xmap("ga",          "<Plug>(EasyAlign)")
-- sort
-- :EasyAlign -,

local wk = require "which-key"
local show = wk.show
wk.show = function(keys, opts)
	if vim.bo.filetype == "TelescopePrompt" then
		return
	end
	show(keys, opts)
end

-- isort
require("Comment").setup({})
require("formatter").setup({
	filetype = {
		python = { require("formatter.filetypes.python").autopep8 },
		c = {
			function()
				return {
					exe = "uncrustify",
					args = { "-q", "-l C" },
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "uncrustify",
					args = { "-q", "-l C" },
					stdin = true,
				}
			end,
		},
		lua = { require("formatter.filetypes.lua").stylua },
		dart = {
			function()
				return { exe = "flutter format", stdin = false }
			end,
		},
		go = { require("formatter.filetypes.go").gofumpt },
		haskell = {
			function()
				return { exe = "fourmolu", stdin = true }
			end,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--edition 2021" },
					stdin = true,
				}
			end,
		},
	},
})
require("gitsigns").setup({})
require("lualine").setup({
	options = {
		theme = "moonfly",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
})
require("nvim-autopairs").setup({})
require("nvim-lsp-installer").setup({ automatic_installation = false })
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"go",
		"java",
		"lua",
		"python",
		"rust",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
require("rust-tools").setup({})
require("inc_rename").setup({})
require("tabline").setup({ no_name = "[]" })
require("telescope").setup({
	defaults = {
		mappings = {
			n = { ["<Leader>q"] = require("telescope.actions").close },
		},
	},
})
require("telescope").load_extension "ui-select"
require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	insert_mapping = false,
	direction = "float",
})
require("which-key").setup({})
require("flutter-tools").setup({
	lsp = {
		color = {
			enabled = true,
			background = false,
			foreground = false,
			virtual_text = true,
			virtual_text_str = "???",
		},
	},
})
-- isort

local cmp = require "cmp"
cmp.setup.cmdline(":", {
	sources = { { name = "cmdline" } },
	mapping = cmp.mapping.preset.cmdline({}),
})
cmp.setup.cmdline("/", {
	sources = { { name = "buffer" } },
	mapping = cmp.mapping.preset.cmdline({}),
})

local on_confirm_done = require("nvim-autopairs.completion.cmp").on_confirm_done({
	map_char = { tex = "" },
})

cmp.event:on("confirm_done", on_confirm_done)

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
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
					""
				)
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#available"](1) ~= 0 then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true),
					""
				)
			else
				fallback()
			end
		end,
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {
			"i",
			"c",
		}),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(_), { "i", "c" }),
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
	}),
	{ { name = "buffer" } },
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

local lua_dev = require("lua-dev").setup({
	capabilities = capabilities,
	settings = { Lua = { format = { enable = false } } },
})

table.insert(lua_dev.settings.Lua.workspace.library, "/usr/share/awesome/lib")
lua_dev.settings.Lua.diagnostics = {
	disable = { "lowercase-global" },
	globals = { "client", "awesome", "screen", "root" },
}

local def = { capabilities = capabilities }
local lsp = require "lspconfig"

lsp.bashls.setup(def)
lsp.clangd.setup(def)
lsp.gopls.setup(def)
lsp.hls.setup(def)
lsp.pyright.setup(def)
lsp.rust_analyzer.setup(def)
lsp.sumneko_lua.setup(lua_dev)
lsp.vimls.setup(def)
