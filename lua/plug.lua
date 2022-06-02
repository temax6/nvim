require("gitsigns").setup()
require("nvim-autopairs").setup()
require("nvim-lsp-installer").setup()
require("which-key").setup()

require("nvim-treesitter.configs").setup({
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

local lsp = require("lspconfig")
local function setup(server, cfg)
	lsp[server].setup(cfg or {})
end

setup("bashls")
setup("ccls")
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
