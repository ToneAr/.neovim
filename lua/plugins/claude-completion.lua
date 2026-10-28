-- AI completions from Claude (via minuet), shown in the blink.cmp menu
return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			provider = "claude",
			request_timeout = 3,
			provider_options = {
				claude = {
					model = "claude-haiku-5-5",
					api_key = "ANTHROPIC_API_KEY",
					max_tokens = 256,
					stream = true,
					optional = {
						-- Keep completions fast: no thinking
						thinking = { type = "disabled" },
					},
				},
			},
		},
	},
}
