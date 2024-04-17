return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerOpen",
		"OverseerClose",
		"OverseerToggle",
		"OverseerSaveBundle",
		"OverseerLoadBundle",
		"OverseerDeleteBundle",
		"OverseerRunCmd",
		"OverseerRun",
		"OverseerInfo",
		"OverseerBuild",
		"OverseerQuickAction",
		"OverseerTaskAction",
		"OverseerClearCache",
	},
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function(opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		require("dap.ext.vscode").json_decode = require("overseer.json").decode
		overseer.patch_dap(true)
	end,
	opts = {
		dap = false,
	},
}
