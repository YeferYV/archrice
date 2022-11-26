-- automatic installation
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

-- Packer autocompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- packer options
packer.init({
	-- max_jobs = 5,
	git = {
		depth = 1,
		clone_timeout = 100,
	},
})

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" })

	-- Auto pairs for '(' '[' '{'
	use({
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
		commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	-- Better tabline
	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })

	-- scope buffers to tabs
	use({
		"tiagovla/scope.nvim",
		commit = "2db6d31de8e3a98d2b41c0f0d1f5dc299ee76875",
		config = function()
			require("scope").setup()
		end,
	})

	-- Colors
	-- use { 'TheNiteCoder/mountaineer.vim' }
	-- use { 'mountain-theme/Mountain' }
	-- use { 'pradyungn/Mountain', rtp='vim' }
	use({ "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb1" })
	-- use { 'lunarvim/colorschemes', commit = "2ddcd2a552583c1ca3659910b44c07c52778a0a6" }
	-- use { 'ChristianChiarulli/nvcode-color-schemes.vim'}
	-- :lua base16 = require'base16'; base16(base16.themes.mountain2, true)
	-- use { 'norcalli/nvim-base16.lua',
	--   config = function() local base16 = require('base16')
	--     base16.themes["mountain2"] = {
	--        base00 = "0f0f0f";
	--        base01 = "151515";
	--        base02 = "191919";
	--        base03 = "222222";
	--        base04 = "535353";
	--        base05 = "d8d8d8";
	--        base06 = "e6e6e6";
	--        base07 = "f0f0f0";
	--        base08 = "b18f91";
	--        base09 = "d8bb92";
	--        base0A = "b1ae8f";
	--        base0B = "8aac8b";
	--        base0C = "91b2b3";
	--        base0D = "a5a0c2";
	--        base0E = "ac8aac";
	--        base0F = "b39193";
	--     }
	--   end
	-- }
	-- use { 'Mofiqul/dracula.nvim',
	--   config = function() vim.g.dracula_colors = {
	--       bg = "#000000",
	--       fg = "#ffffff",
	--       selection = "#111111",
	--       comment = "#555555",
	--       red = "#bb0000",
	--       orange = "#1c1cff",
	--       yellow = "#ffff00",
	--       green = "#00ff00",
	--       purple = "#8855ff",
	--       cyan = "#7acaca",
	--       pink = "#ff0000",
	--       bright_red = "#ff0000",
	--       bright_green = "#008800",
	--       bright_yellow = "#bbbb00",
	--       bright_blue = "#5555ff",
	--       bright_magenta = "#880088",
	--       bright_cyan = "#008888",
	--       bright_white = "#FFFFFF",
	--       menu = "#000000",
	--       visual = "#555555",
	--       gutter_fg = "#1c1cff",
	--       nontext = "#000000",
	--       white = "#cccccc",
	--       black = "#222222",
	--     }
	--   end
	-- }

	-- Comment block of codes
	-- use { 'tpope/vim-commentary', commit = "3654775824337f466109f00eaf6759760f65be34" }
	use({
		"numToStr/Comment.nvim",
		commit = "2c26a00f32b190390b664e56e32fd5347613b9e2",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269",
		opt = true,
	})

	-- cmp plugins
	-- use { 'hrsh7th/nvim-cmp', branch = "border-window" } -- The completion plugin
	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }) -- lsp completions

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

	-- File Explorer
	use({ "kyazdani42/nvim-tree.lua", commit = "09a51266bca28dd87febd63c66bdbd74f7764a63" })

	-- For snippets completion
	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

	-- For ultisnips users
	-- use { 'SirVer/ultisnips',
	--   commit = "5fc4862eea9bc72cf0f03c56a4a09fd76d9fee35",
	--   requires = {
	--     { 'honza/vim-snippets', commit = "222cf7b44bb569c9a046a9891000c898bd4c43c9" },
	--     { 'quangnguyen30192/cmp-nvim-ultisnips', commit = "21f02b62deb409ce69928a23406076bd0043ddbc" },
	--   },
	-- }

	-- Intellisense
	-- use {'tzachar/cmp-tabnine', commit = "e23d32a76304496aade4e4b285751a6a8b505491", run = 'powershell ./install.ps1'}
	use({ "tzachar/cmp-tabnine", commit = "e23d32a76304496aade4e4b285751a6a8b505491", run = "./install.sh" })
	use({ "github/copilot.vim", commit = "c2e75a3a7519c126c6fdb35984976df9ae13f564" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters
  use({ "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" })
	use({
		"williamboman/mason.nvim",
		commit = "49c7826ebca62374df44b20fcd0df7a287d4511d",
		config = function()
			require("mason").setup()
		end,
		requires = {
			"williamboman/mason-lspconfig.nvim",
			commit = "f0d0d62273b76fa0ef5154ce9d05b1a2a083e79b",
			config = function()
				require("mason-lspconfig").setup()
			end,
		},
	})

	-- Status line
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd"})
  use({ "kyazdani42/nvim-web-devicons", commmit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })

	-- whichkey
	use({ "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71", })

	-- Surround block of codes
	use({ "tpope/vim-surround", commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea" })

	-- Sxhkd syntax highlighting
	-- use({ "kovetskiy/sxhkd-vim", commit = "2760f9d32bd2fb4d7d5305a88eb2056d149c6484", ft = { "sxhkd" } })

	-- Syntax hightlighting
	-- use { 'nvim-treesitter/playground', commit = "71b00a3c665298e5155ad64a9020135808d4e3e8" }
	use({ "nvim-treesitter/nvim-treesitter", commit = "518e27589c0463af15463c9d675c65e464efc2fe" })
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "b1e850b77e57b2720c06d523d6fc4776ad6a5608",
		opt = true,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		commit = "c18e016864c92ecf9775abea1baaa161c28082c3",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
					change = {
						hl = "GitSignsChange",
						text = "│",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "_",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "‾",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "~",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
			})
		end,
	})

	-- Telescope
	use({ "nvim-telescope/telescope.nvim",
    commit = "cea9c75c19d172d2c6f089f21656019734a615cf",
		requires = {
      { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" },
      { "nvim-telescope/telescope-fzf-native.nvim", commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90" , run = "make" }
    }
	})

  -- UI
  use { "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" }
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }

	-- The interactive scratchpad (aka playground or quokka-alt)
	-- use({ "metakirby5/codi.vim", commit = "c120785c950f9991d32d3d4d2f3696fa8a8b5582" })

	-- Vim Jump to Match words
	-- use { 'andymass/vim-matchup',
	--   commit="976ebfe61b407d0a75d87b4a507bf9ae4ffffbaa",
	--   event = 'VimEnter'
	-- }

	-- Vim more Text Objects
	-- use { 'wellle/targets.vim',
	--   commit="8d6ff2984cdfaebe5b7a6eee8f226a6dd1226f2d",
	--   event = 'VimEnter'
	-- }

	-- Vim Terminal
	use({ "akinsho/toggleterm.nvim", commit = "62683d927dfd30dc68441a5811fdcb6c9f176c42" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
