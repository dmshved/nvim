-- dmshved v1.1
-- hello there :)

vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg, bg = "#000000" })

-- =======================================================================================================================
-- options
-- =======================================================================================================================

vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "123" -- show a column at 123 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 2 -- obsidian requirement
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
vim.opt.display = "lastline"

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

-- vim.opt.guicursor =
-- 	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50" -- cursor block settings

-- folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- =======================================================================================================================
-- status line
-- =======================================================================================================================

-- git branch function with caching and Nerd Font icon
local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = vim.uv.now()
	if now - last_check > 5000 then -- check every 5 seconds
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	if cached_branch ~= "" then
		return " \u{e725} " .. cached_branch .. " " -- nf-dev-git_branch
	end
	return ""
end

-- file type with Nerd Font icon
local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		cs = "\u{f031b} ", -- nf-dev-cs
		lua = "\u{e620} ", -- nf-dev-lua
		python = "\u{e73c} ", -- nf-dev-python
		javascript = "\u{e74e} ", -- nf-dev-javascript
		typescript = "\u{e628} ", -- nf-dev-typescript
		javascriptreact = "\u{e7ba} ",
		typescriptreact = "\u{e7ba} ",
		html = "\u{e736} ", -- nf-dev-html5
		css = "\u{e749} ", -- nf-dev-css3
		scss = "\u{e749} ",
		json = "\u{e60b} ", -- nf-dev-json
		markdown = "\u{e73e} ", -- nf-dev-markdown
		vim = "\u{e62b} ", -- nf-dev-vim
		sh = "\u{f489} ", -- nf-oct-terminal
		bash = "\u{f489} ",
		zsh = "\u{f489} ",
		rust = "\u{e7a8} ", -- nf-dev-rust
		go = "\u{e724} ", -- nf-dev-go
		c = "\u{e61e} ", -- nf-dev-c
		cpp = "\u{e61d} ", -- nf-dev-cplusplus
		java = "\u{e738} ", -- nf-dev-java
		php = "\u{e73d} ", -- nf-dev-php
		ruby = "\u{e739} ", -- nf-dev-ruby
		swift = "\u{e755} ", -- nf-dev-swift
		kotlin = "\u{e634} ",
		dart = "\u{e798} ",
		elixir = "\u{e62d} ",
		haskell = "\u{e777} ",
		sql = "\u{e706} ",
		yaml = "\u{f481} ",
		toml = "\u{e615} ",
		xml = "\u{f05c} ",
		dockerfile = "\u{f308} ", -- nf-linux-docker
		gitcommit = "\u{f418} ", -- nf-oct-git_commit
		gitconfig = "\u{f1d3} ", -- nf-fa-git
		vue = "\u{fd42} ", -- nf-md-vuejs
		svelte = "\u{e697} ",
		astro = "\u{e628} ",
	}

	if ft == "" then
		return " \u{f15b} " -- nf-fa-file_o
	end

	return ((icons[ft] or " \u{f15b} ") .. ft)
end

-- file size with Nerd Font icon
local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	local size_str
	if size < 1024 then
		size_str = size .. "B"
	elseif size < 1024 * 1024 then
		size_str = string.format("%.1fK", size / 1024)
	else
		size_str = string.format("%.1fM", size / 1024 / 1024)
	end
	return " \u{f016} " .. size_str .. " " -- nf-fa-file_o
end

-- mode indicators with Nerd Font icons
local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK",
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK",
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL",
	}
	return modes[mode] or (" \u{f059} " .. mode)
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- function to change statusline based on window focus
local function setup_dynamic_statusline()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				" ",
				"%#StatusLineBold#",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
				" | %f %h%m%r", -- nf-pl-left_hard_divider
				"%{v:lua.git_branch()}",
				"| ", -- nf-pl-left_hard_divider
				"%{v:lua.file_type()}",
				"| ", -- nf-pl-left_hard_divider
				"%{v:lua.file_size()}",
				"%=", -- right-align everything after this
				" | pos: %l:%c %P | \u{f017} %{strftime('%H:%M')}", -- cursor position and clock
				-- " | pos: %l:%c %P | %{strftime('%d-%B-%A | \u{f017} %H:%M')}", -- cursor position, date and clock
				" ",
			})
		end,
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r | %{v:lua.file_type()} %=  %l:%c   %P "
		end,
	})
end

setup_dynamic_statusline()

-- =======================================================================================================================
-- keymaps
-- =======================================================================================================================

vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Change directory" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Enter insert mode" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- termux panes settings
-- vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move to left window/pane" })
-- vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move to bottom window/pane" })
-- vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move to top window/pane" })
-- vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move to right window/pane" })

-- alacrity panes settings
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window/pane" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window/pane" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window/pane" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window/pane" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })

vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- =======================================================================================================================
-- autocmds
-- =======================================================================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- format on keymap(ONLY real file buffers, ONLY when efm is attached and for roslyn separately)
vim.api.nvim_create_user_command("Format", function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- avoid formatting non-file buffers (helps prevent weird write prompts)
	if vim.bo[bufnr].buftype ~= "" then
		return
	end

	if not vim.bo[bufnr].modifiable then
		return
	end

	if vim.api.nvim_buf_get_name(bufnr) == "" then
		return
	end

	if vim.bo[bufnr].filetype == "cs" then
		pcall(vim.lsp.buf.format, {
			bufnr = bufnr,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "roslyn_ls"
			end,
		})

		return
	end

	local has_efm = false
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if c.name == "efm" then
			has_efm = true
			break
		end
	end

	if not has_efm then
		return
	end

	pcall(vim.lsp.buf.format, {
		bufnr = bufnr,
		timeout_ms = 2000,
		filter = function(c)
			return c.name == "efm"
		end,
	})
end, { desc = "Format code with :Format" })

-- -- format on save (ONLY real file buffers, ONLY when efm is attached and for roslyn separately)
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = augroup,
-- 	pattern = {
-- 		"*.cs",
-- 		"*.lua",
-- 		"*.py",
-- 		"*.go",
-- 		"*.js",
-- 		"*.jsx",
-- 		"*.ts",
-- 		"*.tsx",
-- 		"*.json",
-- 		"*.css",
-- 		"*.scss",
-- 		"*.html",
-- 		"*.sh",
-- 		"*.bash",
-- 		"*.zsh",
-- 		"*.c",
-- 		"*.cpp",
-- 		"*.h",
-- 		"*.hpp",
-- 	},
-- 	callback = function(args)
-- 		-- avoid formatting non-file buffers (helps prevent weird write prompts)
-- 		if vim.bo[args.buf].buftype ~= "" then
-- 			return
-- 		end
--
-- 		if not vim.bo[args.buf].modifiable then
-- 			return
-- 		end
--
-- 		if vim.api.nvim_buf_get_name(args.buf) == "" then
-- 			return
-- 		end
--
-- 		-- c# will be formatted by roslyn_ls
-- 		if vim.bo[args.buf].filetype == "cs" then
-- 			pcall(vim.lsp.buf.format, {
-- 				bufnr = args.buf,
-- 				timeout_ms = 2000,
-- 				filter = function(c)
-- 					return c.name == "roslyn_ls"
-- 				end,
-- 			})
--
-- 			return
-- 		end
--
-- 		local has_efm = false
-- 		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
-- 			if c.name == "efm" then
-- 				has_efm = true
-- 				break
-- 			end
-- 		end
--
-- 		if not has_efm then
-- 			return
-- 		end
--
-- 		pcall(vim.lsp.buf.format, {
-- 			bufnr = args.buf,
-- 			timeout_ms = 2000,
-- 			filter = function(c)
-- 				return c.name == "efm"
-- 			end,
-- 		})
-- 	end,
-- })

-- -- default highlight yanked text
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	group = augroup,
-- 	callback = function()
-- 		vim.hl.on_yank()
-- 	end,
-- })

-- light blue highlight yanked color
vim.api.nvim_set_hl(0, "YankHighlight", {
	bg = "#90D5FF",
	fg = "#1e1e1e",
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank({
			higroup = "YankHighlight",
			timeout = 100,
		})
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- =======================================================================================================================
-- plugins (vim.pack)
-- =======================================================================================================================

vim.pack.add({
	-- gitsigns.nvim
	"https://github.com/lewis6991/gitsigns.nvim",

	-- mini.nvim
	"https://www.github.com/echasnovski/mini.nvim",

	-- nvim-treesitter
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},

	-- easy-dotnet.nvim
	"https://github.com/GustavEikaas/easy-dotnet.nvim",

	-- language server protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",

	-- nvim-tree
	-- "https://www.github.com/nvim-tree/nvim-tree.lua",

	-- fzf-lua
	"https://www.github.com/ibhagwan/fzf-lua",

	-- plenary (harpoon dependency)
	"https://github.com/nvim-lua/plenary.nvim",

	-- harpoon
	{
		src = "https://github.com/theprimeagen/harpoon",
		branch = "harpoon2",
	},

    -- rustaceanvim
    {
        src = 'https://github.com/mrcjkb/rustaceanvim',
        -- To avoid being surprised by breaking changes,
        -- I recommend you set a version range
        version = vim.version.range('^9')
    }
})

-- =======================================================================================================================
-- plugin configs
-- =======================================================================================================================

-- nvim-treesitter
config =
	function()
		local ts = require("nvim-treesitter")
		local parsers = {
			"c_sharp",
			"vim",
			"vimdoc",
			"diff",
			"dockerfile",
			"git_config",
			"gitcommit",
			"gitignore",
			"rust",
			"c",
			"cpp",
			"go",
			"html",
			"css",
			"javascript",
			"json",
			"lua",
			"markdown",
			"python",
			"typescript",
			"vue",
			"bash",
			"yaml",
			"toml",
		}

		for _, parser in ipairs(parsers) do
			ts.install(parser)
		end

		-- not every tree-sitter parser is the same as the file type detected
		-- so the patterns need to be registered more cleverly
		local patterns = {}
		for _, parser in ipairs(parsers) do
			local parser_patterns = vim.treesitter.language.get_filetypes(parser)
			for _, pp in pairs(parser_patterns) do
				table.insert(patterns, pp)
			end
		end

		vim.treesitter.language.register("groovy", "Jenkinsfile")
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = patterns,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
	-- nvim-tree
	-- require("nvim-tree").setup({
	-- 	view = {
	-- 		width = 35,
	--         side = "right",
	-- 	},
	-- 	filters = {
	-- 		dotfiles = false,
	-- 	},
	-- 	renderer = {
	-- 		group_empty = true,
	-- 	},
	-- })
	-- vim.keymap.set("n", "<leader>e", function()
	-- 	require("nvim-tree.api").tree.toggle()
	-- end, { desc = "Toggle NvimTree" })
	--
	-- vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
	-- vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-- fzf-lua
require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })

vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })

vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })

vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })

vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })

vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

-- harpoon
require("harpoon").setup({})

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon Add File" })

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Toggle Quick Menu" })

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end, { desc = "Harpoon Select 1" })

vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end, { desc = "Harpoon Select 2" })

vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(3)
end, { desc = "Harpoon Select 3" })

vim.keymap.set("n", "<C-n>", function()
	harpoon:list():next()
end, { desc = "Harpoon Next" })

vim.keymap.set("n", "<C-p>", function()
	harpoon:list():prev()
end, { desc = "Harpoon Previous" })

-- mini.nvim
require("mini.ai").setup({}) -- extend and create a/i textobjects
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
-- require("mini.indentscope").setup({
--     draw = {
--         animation = require('mini.indentscope').gen_animation.none(),
--     },
--
--     -- symbol = '╎',
--     symbol = '|',
-- })

require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.icons").setup({})

-- gitsigns.nvim
require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" },
		change = { text = "\u{2590}" },
		delete = { text = "\u{2590}" },
		topdelete = { text = "\u{25e6}" },
		changedelete = { text = "\u{25cf}" },
		untracked = { text = "\u{25cb}" },
	},
	signcolumn = true,
	current_line_blame = false,
})

vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })

vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })

vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })

vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

-- mason
require("mason").setup({})

-- easy-dotnet.nvim
local dotnet = require("easy-dotnet")

dotnet.setup({
	dependencies = {},
	config = function()
		dotnet.setup({
			managed_terminal = {},
			external_terminal = nil,
			projx_lsp = {},
			lsp = {
				enabled = true, -- enable builtin roslyn lsp
				set_fold_expr = false,
				preload_roslyn = true, -- start loading roslyn before any buffer is opened
				roslynator_enabled = true, -- autometically enable roslynator analyzer
				easy_dotnet_analyzer_enabled = true, -- enable roslyn analyzer from easy-dotnet-server
				restart_roslyn_on_branch_change = false, -- restart Roslyn when Git HEAD changes
				auto_refresh_codelens = false, -- true by default
				suggest_updates = false, -- periodically suggest roslyn-language-server updates
				analyzer_assemblies = {}, -- any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
				razor = {
					enabled = true,
					html = {
						enabled = true,
						cmd = nil, -- auto-detect project node_modules/.bin/vscode-html-language-server, then PATH
						request_timeout = 5000,
					},
				},
				config = {
					settings = {
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = false,
						},
					},
                },
			},
			debugger = {},
			---@type TestRunnerOptions
			test_runner = {},
			new = {
				project = {
					prefix = "sln", -- "sln" | "none"
				},
			},
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				--block_scoped, file_scoped
				type = "block_scoped",
				enabled = true,
				use_clipboard_json = {},
			},
			server = {
				---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				log_level = nil,
			},
			picker = "fzf",
			notifications = {},
			diagnostics = {
				default_severity = "error",
				setqflist = false,
			},
			outdated = {
				mappings = {},
			}
		})

		vim.api.nvim_create_user_command("Secrets", function()
			dotnet.secrets()
		end, { desc = "Easy Dotnet Secrets" })

		vim.keymap.set("n", "<C-p>", function()
			dotnet.run_project()
		end, { desc = "Easy Dotnet Run Project" })
	end,
})

-- =======================================================================================================================
-- lsp, linting, formatting & completion
-- =======================================================================================================================

local diagnostic_signs = {
	Error = "\u{f057} ",
	Warn = "\u{f071} ",
	Hint = "\u{ea61}",
	Info = "\u{f05a}",
}

vim.diagnostic.config({
	virtual_text = { prefix = "\u{f0764}", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		-- border = "rounded",
		border = "square",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- blink.cmp
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		},
	},
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("rustaceanvim", {})

vim.g.rustaceanvim = {
	server = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	},
}

-- linting & formatting
do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local cpplint = require("efmls-configs.linters.cpplint")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local go_revive = require("efmls-configs.linters.go_revive")
	local gofumpt = require("efmls-configs.formatters.gofumpt")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				c = { clangfmt, cpplint },
				go = { gofumpt, go_revive },
				cpp = { clangfmt, cpplint },
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
			},
		},
	})
end

vim.lsp.enable({
	"lua_ls",
	"rustaceanvim",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"clangd",
	"efm",
})

-- =======================================================================================================================
-- floating terminal
-- =======================================================================================================================

vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function ()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = vim.bo[terminal_state.buf].buftype == "terminal"
	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	local term_augroup = vim.api.nvim_create_augroup("FloatingTermLeave_" .. terminal_state.win, { clear = true })
	vim.api.nvim_create_autocmd("BufLeave", {
		group = term_augroup,
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Terminal normal mode" })
vim.keymap.set("t", "<C-q>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal" })
