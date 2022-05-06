return {
	-- ["auto-session"] = { log_level = "info" },
	-- ["session-lens"] = {
	-- 	require("telescope").load_extension("session-lens"),
	-- },
	bufferline = {},
	Comment = {},
	-- ["flutter-tools"] = {lsp = {autostart = true}},
	gitsigns = {},

	cmp = function(cmp)
		cmp.setup.cmdline(
			":",
			{ sources = { { name = "cmdline" } }, mapping = cmp.mapping.preset.cmdline({}) }
		)
		cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

		return {
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = {
				["<Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif vim.fn["vsnip#available"](1) ~= 0 then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes(
								"<Plug>(vsnip-expand-or-jump)",
								true,
								true,
								true
							),
							""
						)
					else
						fallback()
					end
				end,
				["<S-Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif vim.fn["vsnip#available"](1) ~= 0 then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes(
								"<Plug>(vsnip-jump-prev)",
								true,
								true,
								true
							),
							""
						)
					else
						fallback()
					end
				end,
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable,
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
		}
	end,
	indent_blankline = { check_ts = true },
	lualine = {
		options = { theme = "moonfly" },
		-- sections = {
		-- 	lualine_c = {
		-- 		require("auto-session-library").current_session_name,
		-- 	},
		-- },
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
	--
	["null-ls"] = function(nls)
		return {
			sources = (function()
				local r = {}
				for k, v in pairs(require("cfg.fmt")) do
					table.insert(r, nls.builtins.formatting[k].with(v))
				end
				return r
			end)(),
		}
	end,
	["nvim-tree"] = {
		view = { width = 45 },
	},
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
	-- telescope = function(tsc)
	-- 	tsc.setup({
	-- 		defaults = {
	-- 			mappings = {
	-- 				n = {
	-- 					["<Leader>c"] = require("telescope.actions").close,
	-- 				},
	-- 			},
	-- 		},
	-- 		extensions = {
	-- 			file_browser = {
	-- 				theme = "ivy",
	-- 				mappings = {
	-- 					["i"] = {
	-- 						-- your custom insert mode mappings
	-- 					},
	-- 					["n"] = {
	-- 						-- your custom normal mode mappings
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	-- 	tsc.load_extension("file_browser")
	-- end,
	toggleterm = {
		open_mapping = [[<s-t>]],
		insert_mappings = false,
		direction = "float",
	},
}