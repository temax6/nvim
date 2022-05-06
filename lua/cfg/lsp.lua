return {
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
		on_attach = function(client, _)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			-- client.server_capabilities.document_formatting = false
			-- client.server_capabilities.document_range_formatting = false
		end,
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
