return {
	"rcarriga/nvim-notify",
	keys = {
		{
			"<leader><space>",
			function() require("notify").dismiss { silent = true, pending = true } end,
			desc = "[Notify] Dismiss all notifications",
		},
	},
	opts = {
		timeout = 3000,
		top_down = false,
		max_height = function() return math.floor(vim.o.lines * 0.75) end,
		max_width = function() return math.floor(vim.o.columns * 0.75) end,
		on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
	},
}
