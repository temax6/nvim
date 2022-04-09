local M = {}

M.setup = {
	bufferline = {},
	Comment = {},
	gitsigns = {},
	cmp = require("cfg.comp"),
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
		rainbow = {
			enable = true,
		},
	},
	toggleterm = {
		open_mapping = [[<s-t>]],
		insert_mappings = false,
		direction = "float",
	},
}

M.lsp = {
	-- jdtls = {},
	-- eslint = {},
	bashls = {},
	clangd = {},
	gopls = {},
	hls = {},
	pyright = {},
	rust_analyzer = {},
	texlab = {},
	tsserver = {
		on_attach = function(client, _)
			local ltu = require("nvim-lsp-ts-utils")
			ltu.setup({
				filter_out_diagnostics_by_code = { 80001 },
			})
			ltu.setup_client(client)
		end,
	},
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
