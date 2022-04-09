local map = vim.api.nvim_set_keymap
local nore = { silent = true, noremap = true }
local re = { silent = true }

map("", "<Space>", "<Nop>", nore)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function cmd(c)
	return ":" .. c .. "<CR>"
end

local function lua(c)
	return cmd("lua " .. c)
end

local function tele(c)
	return cmd("Telescope " .. c)
end

local function l(k)
	return "<Leader>" .. k
end

local modes = {
	normal = "n",
	insert = "i",
	visual = "v",
	block = "x",
	command = "c",
	terminal = "t",
}

local maps = {
	normal = {
		{ l("d"), lua("vim.diagnostic.open_float()") },
		{ l("D"), tele("diagnostics") },
		{ l("h"), lua("vim.lsp.buf.hover()"), lsp = true },
		{ l("r"), lua("vim.lsp.buf.rename()"), lsp = true },
		{ l("f"), lua("vim.lsp.buf.formatting_seq_sync()"), lsp = true },
		{ l("g"), tele("lsp_definitions") },
		{ l("a"), tele("lsp_code_actions") },
		{ "<C-Down>", cmd("resize +2") },
		{ "<C-Left>", cmd("vertical resize -2") },
		{ "<C-Right>", cmd("vertical resize +2") },
		{ "<C-Up>", cmd("resize -2") },
		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
		{ "<S-h>", "^" },
		{ "<S-j>", cmd("bnext") },
		{ "<S-k>", cmd("bprevious") },
		{ "<S-l>", "$" },
		{ l("/"), "gcc", opts = re },
		{ l("W"), cmd("w !sudo tee %") },
		{ l("c"), cmd("bdelete!") },
		{ l("l"), cmd("noh") },
		{ l("pdf"), cmd("silent! !mupdf %:p:r.pdf &") },
		{ l("q"), cmd("q!") },
		{ l("w"), cmd("w!") },
		{ "<C-f>", tele("current_buffer_fuzzy_find") },
		{ "<C-s>", tele("buffers") },
		{ "<C-e>", tele("git_files hidden=true") },
		{ "<C-o>", tele("find_files hidden=true") },
		{ "<C-r>", tele("oldfiles") },
		{ l("t"), tele("builtin") },
	},
	insert = {
		{ "jk", "<ESC>" },
	},
	visual = {
		{ "<S-h>", "^", opts = re },
		{ "<S-l>", "$", opts = re },
		{ l("/"), "gc", opts = re },
		{ l("c"), '"*y' },
	},
	block = {
		{ l("c"), '"*y' },
	},
	command = {},
	terminal = {
		{ "jk", "<ESC>" },
	},
}

for k, v in pairs(maps) do
	for m in pairs(v) do
		m = v[m]
		if not m.lsp then
			map(modes[k], m[1], m[2], m.opts == nil and nore or m.opts)
		end
	end
end

return function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	for k, v in pairs(maps) do
		for m in pairs(v) do
			m = v[m]
			if m.lsp then
				vim.api.nvim_buf_set_keymap(bufnr, modes[k], m[1], m[2], m.opts == nil and nore or m.opts)
			end
		end
	end
end

-- keymap("n", "<Leader>e", ":TroubleToggle document_diagnostics<CR>", opts)
--
-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
--
-- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
