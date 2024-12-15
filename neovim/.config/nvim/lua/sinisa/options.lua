-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
-- enable if use with custom statusline that don't have mode showed
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- tabs & indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.autoindent = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "↲" }

-- cursor line
vim.opt.cursorline = true

-- cursor thick
vim.opt.guicursor = ""

--vim.opt.colorcolumn = "80"

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- have some lines on top and bottom
vim.opt.scrolloff = 10

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noinsert,preview"

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- background color (for changes within script)
vim.o.background = "dark"

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
-- vim.opt.statusline = "%!v:lua.require'sinisa'.statusline()"

-- backup and undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- use croatian symbols for more usuful ones
-- vim.opt.langmap = "š[,đ],Š{,Đ}"
