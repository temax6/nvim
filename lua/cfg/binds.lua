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
local function c(k)   return "<C-" .. k .. ">" end

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
		{ l "d",        lua "vim.diagnostic.open_float()"                       },
		{ l "D",        tel "diagnostics"                                       },
		{ l "h",        lua "vim.lsp.buf.hover()",                  lsp = true  },
		{ l "r",        lua "vim.lsp.buf.rename()",                 lsp = true  },
		{ l "f",        lua "vim.lsp.buf.formatting_seq_sync()",    lsp = true  },
		{ l "g",        tel "lsp_definitions"                                   },
		{ l "a",        lua "vim.lsp.buf.code_action()"                         },
		{ c "Down",     cmd "resize +2"                                         },
		{ c "Left",     cmd "vertical resize -2"                                },
		{ c "Right",    cmd "vertical resize +2"                                },
		{ c "Up",       cmd "resize -2"                                         },
		{ c "h",        c "w".."h"                                              },
		{ c "j",        c "w".."j"                                              },
		{ c "k",        c "w".."k"                                              },
		{ c "l",        c "w".."l"                                              },
		{ "H",          "^"                                                     },
		{ "L",          "$"                                                     },
		{ "J",          cmd "bnext"                                             },
		{ "K",          cmd "bprevious"                                         },
		{ l "/",            "gcc",                                  opts = re   },
		{ l "C",        cmd "bdelete!"                                          },
		{ l "c",        cmd "Bdelete!"                                          },
		{ l "l",        cmd "noh"                                               },
		{ l "pdf",      cmd "silent! !mupdf %:p:r.pdf &"                        },
		{ l "q",        cmd "q!"                                                },
		{ l "Q",        cmd "qa!"                                               },
		{ l "w",        cmd "w!"                                                },
		{ l "W",        cmd "w !sudo tee %"                                     },
		{ l "p",        cmd "so % | PackerSync"                                 },
		{ l "m",        cmd "messages"                                          },
		{ "M",              "'"                                                 },
        { l "e",        cmd "TroubleToggle document_diagnostics"                },
		{ c "S-R",      cmd "silent! !ff_refresh.sh"                            },
		{ c "s",        tel "current_buffer_fuzzy_find"                         },
		{ c "a",        tel "buffers"                                           },
		{ c "e",        tel "git_files hidden=true"                             },
		{ c "o",        tel "find_files hidden=true"                            },
		{ c "f",        cmd "NvimTreeToggle"                                    },
		{ c "y",        tel "oldfiles"                                          },
		{ l "t",        tel "builtin"                                           },
		{ l "n",        cmd "tab split"                                         },
		{ c "n",            "gt"                                                },
		{ c "p",            "gT"                                                },
		{ "f",              "<Plug>(leap-forward)"                              },
		{ "F",              "<Plug>(leap-backward)"                             },
	},
	insert = {
		{ "jk",         "<ESC>" },
	},
	visual = {
		{ "H",          "^",                                        opts = re   },
		{ "L",          "$",                                        opts = re   },
		{ l "/",        "gc",                                       opts = re   },
		{ l "c",        '"*y'                                                   },
		{ "f",              "<Plug>(leap-forward)"                              },
		{ "F",              "<Plug>(leap-backward)"                             },
	},
	block = {
		{ l "c",        '"*y'                                                   },
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
				vim.api.nvim_buf_set_keymap(
					bufnr,
					modes[k],
					m[1],
					m[2],
					m.opts == nil and nore or m.opts
				)
			end
		end
	end
end
