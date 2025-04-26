-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "catppuccin",
			},
		},
		{ import = "plugins" },
		{
			"lervag/vimtex",
			--lazy = false,
			init = function()
				vim.g.vimtex_view_method = "zathura"
			end,
		},
		--[[ {
	    "neovim/nvim-lspconfig",
	    opts = {
	    },
    }, ]]
		--
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"bash",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"vim",
					"yaml",
					"rust",
					"cpp",
					"cmake",
					"dockerfile",

					"git_config",
					"gitcommit",
					"git_rebase",
					"gitignore",
					"gitattributes",

					"java",
					"nix",

					"zig",
				},
			},
		},
		{
			"williamboman/mason.nvim",
			optional = true,
			opts = {
				ensure_installed = {
					"codelldb",
					"cmakelang",
					"cmakelint",

					"java-debug-adapter",
					"java-test",
				},
			},
		},
		{
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			opts = {
				completion = {
					crates = {
						enabled = true,
					},
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin", "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

--[[ require("catppuccin").setup({
	compile_path = vim.fn.stdpath "cache" .. "/catppuccin"
	integrations = {
	},
}) ]]
--

vim.cmd.colorscheme("catppuccin-mocha")
