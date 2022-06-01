require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

require("nvim-lsp-installer").setup()
require("gitsigns").setup()

require("telescope").setup({
	defaults = {
		mappings = {
			n = {
				["<Leader>q"] = require("telescope.actions").close,
			},
		},
	},
})

require("which-key").setup()

-- local util = require("formatter.util")
require("formatter").setup({
	filetype = {
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
	},
})

local lsp = require("lspconfig")
local function setup(server, cfg)
	lsp[server].setup(cfg or {})
end

setup("bashls")
setup("ccls")
setup("dartls", { flags = { debounce_text_changes = 1000 } })
setup("sumneko_lua")
setup("vimls")
