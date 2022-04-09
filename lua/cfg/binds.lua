local map = vim.api.nvim_set_keymap
local nore = { silent = true, noremap = true }
local re = { silent = true }

map("", "<Space>", "<Nop>", nore)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local ld = "<Leader>"

local modes = {
	normal = "n",
	insert = "i",
	visual = "v",
	block = "x",
	command = "c",
	terminal = "t",
}

for k, v in pairs({
	normal = {
		{ "<C-Down>", ":resize +2<CR>" },
		{ "<C-Left>", ":vertical resize -2<CR>" },
		{ "<C-Right>", ":vertical resize +2<CR>" },
		{ "<C-Up>", ":resize -2<CR>" },
		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
		{ "<S-h>", "^" },
		{ "<S-j>", ":bnext<CR>" },
		{ "<S-k>", ":bprevious<CR>" },
		{ "<S-l>", "$" },
		{ ld .. "/", "gcc" },
		{ ld .. "W", ":w !sudo tee %<CR>" },
		{ ld .. "a", ":Telescope current_buffer_fuzzy_find<CR>" },
		{ ld .. "c", ":bdelete!<CR>" },
		{ ld .. "d", ":lua vim.diagnostic.open_float()<CR>" },
		{ ld .. "f", ":Telescope find_files<CR>" },
		{ ld .. "h", ":lua vim.lsp.buf.hover()<CR>" },
		{ ld .. "l", ":noh<CR>" },
		{ ld .. "pdf", ":silent! !mupdf %:p:r.pdf &<CR>" },
		{ ld .. "q", ":q!<CR>" },
		{ ld .. "r", ":Telescope oldfiles<CR>" },
		{ ld .. "s", ":Telescope buffers<CR>" },
		{ ld .. "w", ":w!<CR>" },
	},
	insert = {
		{ "jk", "<ESC>" },
	},
	visual = {
		{ "<S-h>", "^", re },
		{ "<S-l>", "$", re },
		{ ld .. "/", "gc", re },
		{ ld .. "c", '"*y' },
	},
	block = {
		{ ld .. "c", '"*y' },
	},
	command = {},
	terminal = {
		{ "jk", "<ESC>" },
	},
}) do
	for m in pairs(v) do
		m = v[m]
		map(modes[k], m[1], m[2], m[3] == nil and nore or m[3])
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
