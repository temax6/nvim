local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect", "noinsert" },
	conceallevel = 0,
	cursorline = true,
	expandtab = true,
	fileencoding = "utf-8",
	ignorecase = true,
	incsearch = true,
	mouse = "a",
	number = true,
	numberwidth = 4,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 999,
	shiftwidth = 4,
	showtabline = 2,
	sidescrolloff = 8,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	timeoutlen = 300,
	undofile = true,
	updatetime = 300,
	wrap = false,
	writebackup = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
vim.diagnostic.config({ virtual_text = false })
vim.g.do_filetype_lua = 1
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.opt.shortmess:append("c")
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.cmd([[
    autocmd BufWritePost *.tex silent! !latexmk -pdf && latexmk -c && pkill -HUP mupdf
]])

vim.cmd([[colorscheme moonfly]])
