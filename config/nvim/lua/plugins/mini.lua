--@module "lazy"
--@type LazyPluginSpec[]
return {
	{
		-- https://github.com/nvim-mini/mini.nvim
		"nvim-mini/mini.nvim",
        lazy = false,
		opts = {
			align = {
				mappings = {
					start = "ga",
					start_with_preview = "gA",
				},
			},
		},
		config = function(_, opts)
			require("mini.align").setup(opts.align)
		end,
	},
}
