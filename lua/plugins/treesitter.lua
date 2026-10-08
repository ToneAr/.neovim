return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'master',
		lazy = false,
		build = ":TSUpdate",
		init = function()
			-- The frozen master branch registers its predicates/directives with
			-- { all = false }, which nvim 0.12 no longer honours (captures are always
			-- TSNode[]). Unwrap to the last node so handlers like downcase! and
			-- set-lang-from-info-string! don't crash on markdown injections.
			if vim.fn.has("nvim-0.12") == 0 then
				return
			end
			local query = vim.treesitter.query
			local function wrap(register)
				return function(name, handler, opts)
					if type(opts) == "table" and opts.all == false then
						local inner = handler
						handler = function(match, ...)
							local single = {}
							for id, nodes in pairs(match) do
								single[id] = type(nodes) == "table" and nodes[#nodes] or nodes
							end
							return inner(single, ...)
						end
					end
					return register(name, handler, opts)
				end
			end
			query.add_directive = wrap(query.add_directive)
			query.add_predicate = wrap(query.add_predicate)
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"python",
					"json",
					"yaml",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"bash",
				},
				auto_install = true,
			})
		end
	}
}
