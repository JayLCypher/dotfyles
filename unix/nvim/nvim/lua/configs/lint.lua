local lint = require("lint")
lint.linters.htmlhint = {
	cmd = "htmlhint",
	stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
	append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
	args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
	stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
	ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
	env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
	parser = function() end,
}

lint.linters.markuplint = {
	cmd = "markuplint",
	stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
	append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
	args = {
		"--no-color",
		"--no-search-config",
		'--config {\
					"extends": [\
						"markuplint:a11y",\
						"markuplint:html-standard",\
						"markuplint:performance",\
						"markuplint:rdfa",\
						"markuplint:security",\
						"markuplint:recommended",\
						"markuplint:recommended-static-html",\
						"markuplint:recommended-react",\
						"markuplint:recommended-vue",\
						"markuplint:recommended-svelte",\
					]\
				}',
	}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
	stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
	ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
	env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
	parser = function() end,
}
