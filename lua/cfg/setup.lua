local binds = require("cfg.binds")
local cmp = require("cmp_nvim_lsp")

local lsp_settings = {
	on_attach = binds,
	capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

local plugconf = require("cfg.plugconf")(lsp_settings)

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
		v.on_attach = lsp_settings.on_attach
	else
		local f = v.on_attach
		v.on_attach = function(client, bufnr)
			lsp_settings.on_attach(client, bufnr)
			f(client, bufnr)
		end
	end
	if v.flags == nil then
		v.flags = { debounce_text_changes = 150 }
	end
	v.capabilities = lsp_settings.capabilities
	require("lspconfig")[k].setup(v)
end
