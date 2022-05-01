local map = vim.api.nvim_set_keymap
local nore = { silent = true, noremap = true }
local re = { silent = true }

map("", "<Space>", "<Nop>", nore)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- stylua: ignore start
local function cmd(c) return ":" .. c .. "<CR>" end
local function lua(c) return cmd("lua " .. c) end
local function tel(c) return cmd("Telescope " .. c) end
local function l(k)   return "<Leader>" .. k end

local modes = {
	normal   = "n",
	insert   = "i",
	visual   = "v",
	block    = "x",
	command  = "c",
	terminal = "t",
}

local maps = {
	normal = {
		{ l("d"),       lua("vim.diagnostic.open_float()")                      },
		{ l("D"),       tel("diagnostics")                                      },
		{ l("h"),       lua("vim.lsp.buf.hover()"),                 lsp = true  },
		{ l("r"),       lua("vim.lsp.buf.rename()"),                lsp = true  },
		{ l("f"),       lua("vim.lsp.buf.formatting_seq_sync()"),   lsp = true  },
		{ l("g"),       tel("lsp_definitions")                                  },
		{ l("a"),       tel("lsp_code_actions")                                 },
		{ "<C-Down>",   cmd("resize +2")                                        },
		{ "<C-Left>",   cmd("vertical resize -2")                               },
		{ "<C-Right>",  cmd("vertical resize +2")                               },
		{ "<C-Up>",     cmd("resize -2")                                        },
		{ "<C-h>",          "<C-w>h"                                            },
		{ "<C-j>",          "<C-w>j"                                            },
		{ "<C-k>",          "<C-w>k"                                            },
		{ "<C-l>",          "<C-w>l"                                            },
		{ "<S-h>",          "^"                                                 },
		{ "<S-j>",      cmd("bnext")                                            },
		{ "<S-k>",      cmd("bprevious")                                        },
		{ "<S-l>",          "$"                                                 },
		{ l("/"),           "gcc",                                  opts = re   },
		{ l("c"),       cmd("bdelete!")                                         },
		{ l("C"),       cmd("Bdelete!")                                         },
		{ l("l"),       cmd("noh")                                              },
		{ l("pdf"),     cmd("silent! !mupdf %:p:r.pdf &")                       },
		{ l("q"),       cmd("q!")                                               },
		{ l("Q"),       cmd("qa!")                                              },
		{ l("w"),       cmd("w!")                                               },
		{ l("W"),       cmd("w !sudo tee %")                                    },
		{ l("p"),       cmd("so % | PackerSync")                                },
		{ l("m"),       cmd("messages")                                         },
		{ "<C-S-R>",    cmd("silent! !ff_refresh.sh")                           },
		{ "<C-f>",      tel("current_buffer_fuzzy_find")                        },
		{ "<C-a>",      tel("buffers")                                          },
		{ "<C-e>",      tel("git_files hidden=true")                            },
		{ "<C-o>",      tel("find_files hidden=true")                           },
		{ "<C-s>",      tel("session-lens search_session")                      },
		{ "<C-p>",      tel("oldfiles")                                         },
		{ l("t"),       tel("builtin")                                          },
	},
	insert = {
		{ "jk",         "<ESC>" },
	},
	visual = {
		{ "<S-h>",      "^",                                        opts = re   },
		{ "<S-l>",      "$",                                        opts = re   },
		{ l("/"),       "gc",                                       opts = re   },
		{ l("c"),       '"*y'                                                   },
	},
	block = {
		{ l("c"),       '"*y'                                                   },
	},
	command = {},
	terminal = {
		{ "jk",         "<ESC>"                                                 },
	},
}
-- stylua: ignore end

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
