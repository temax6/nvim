local binds = require("cfg.binds")
local plugconf = require("cfg.plugconf")

for k, v in pairs(plugconf) do
	local plug = require(k)
	if type(v) == "function" then
		v = v(plug)
	end
	if v ~= nil then
		plug.setup(v)
	end
end

for k, v in pairs(require("cfg.lsp")) do
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
	v.capabilities = require("cmp_nvim_lsp").update_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)
	require("lspconfig")[k].setup(v)
end
