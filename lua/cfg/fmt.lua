return {
	autopep8 = {},
	dart_format = {},
	fish_indent = {},
	fourmolu = {},
	gofmt = {},
	rustfmt = {},
	stylua = { extra_args = { "-" .. "-column-width", "100" } },
	clang_format = { args = { "-style=file:/home/toby/.clang-format" } },
	latexindent = { extra_args = { "-g" } },
	prettierd = {
		env = {
			PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
				"~/.config/nvim/utils/linter-config/.prettierrc.json"
			),
		},
	},
}
