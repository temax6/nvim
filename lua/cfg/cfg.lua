local M = {}

M.setup = {
	["auto-session"] = { log_level = "info" },
	["session-lens"] = {
		require("telescope").load_extension("session-lens"),
	},
	bufferline = {},
	Comment = {},
	-- ["flutter-tools"] = {lsp = {autostart = true}},
	gitsigns = {},
	cmp = require("cfg.comp"),
	indent_blankline = { check_ts = true },
	lualine = {
		options = { theme = "moonfly" },
		sections = {
			lualine_c = {
				require("auto-session-library").current_session_name,
			},
		},
	},
	-- ["nvim-autopairs"] = {
	-- 	show_current_context_start = true,
	-- 	use_treesitter = true,
	-- 	buftype_exclude = { "terminal", "nofile" },
	-- 	filetype_exclude = {
	-- 		"help",
	-- 		"alpha",
	-- 		"packer",
	-- 		"Trouble",
	-- 	},
	-- },
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
	telescope = {
		defaults = {
			mappings = {
				n = {
					["<Leader>c"] = require("telescope.actions").close,
				},
			},
		},
	},
	toggleterm = {
		open_mapping = [[<s-t>]],
		insert_mappings = false,
		direction = "float",
	},
}

M.lsp = {
	jdtls = { cmd = { "jdtls" } },
	-- java_language_server = { cmd = { "java-language-server" } },
	-- eslint = {},
	bashls = {},
	clangd = {},
	dartls = {},
	gopls = {},
	hls = {},
	html = {
		capabilities = function()
			local c = vim.lsp.protocol.make_client_capabilities()
			c.textDocument.completion.completionItem.snippetSupport = true
			return c
		end,
		-- on_attach = function(client, bufnr)
		-- 	if client.resolved_capabilities.completion then
		-- 		require("completion").on_attach(client, bufnr)
		-- 	end
		-- end,
		-- cmd = { "vscode-html-languageserver", "--stdio" }
	},
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
	zls = {},
}

M.fmt = {
	autopep8 = {},
	dart_format = {},
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
