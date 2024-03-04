return {
	"TobinPalmer/Tip.nvim",
	event = "VimEnter",
	init = function()
		-- Default config
		--- @type Tip.config
		require("tip").setup {
			seconds = 2,
			title = "Tip!",
			url = "https://vimiscool.tech/neotip", -- Or https://vtip.43z.one
		}
	end,
}
