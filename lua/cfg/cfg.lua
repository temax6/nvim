local M = {}

M.setup = {
	bufferline = {},
	Comment = {},
	gitsigns = {},
	cmp = require("cfg.cmp"),
	indent_blankline = { check_ts = true },
	lualine = { options = { theme = "moonfly" } },
	["nvim-autopairs"] = {
		show_current_context_start = true,
		use_treesitter = true,
		buftype_exclude = { "terminal", "nofile" },
		filetype_exclude = {
			"help",
			"alpha",
			"packer",
			"Trouble",
		},
	},
	["nvim-treesitter.configs"] = {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = false,
		},
	},
	toggleterm = {
		open_mapping = [[<s-t>]],
		insert_mappings = false,
		direction = "float",
	},
}

M.lsp = {
	bashls = {},
	clangd = {},
	eslint = {},
	gopls = {},
	hls = {},
	pyright = {},
	rust_analyzer = {},
	texlab = {},
	-- "tsserver",
	-- "jdtls",

	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "on_attach", "PACKER_BOOTSTRAP" },
				},
			},
		},
	},
}

M.fmt = {
	autopep8 = {},
	fish_indent = {},
	fourmolu = {},
	gofmt = {},
	rustfmt = {},
	stylua = {},
	clang_format = { args = { "-style=file:/home/toby/.clang-format" } },
	latexindent = { extra_args = { "-g" } },
	prettierd = {
		env = {
			PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
		},
	},
}

return M
