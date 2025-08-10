-- options
vim.g.mapleader = " "

vim.opt.number = true
-- spellcheck
vim.opt.spell = true

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- do not use linewrap by default
vim.opt.wrap = false
-- do not break by words at the end of the line
vim.opt.linebreak = false
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", space = "·", lead = "‹" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.confirm = true

-- disable swapfile
vim.opt.swapfile = false

local statusline = {
	" %t",
	"%r",
	"%m",
	"%=",
	"%{&filetype}",
	" %2p%%",
	" %3l:%-2c ",
}
vim.opt.statusline = table.concat(statusline, "")

-- keymaps
-- use ; as :
vim.keymap.set({ "n", "v", "o" }, ";", ":")

-- instead the repeat f, t command is set to ,
vim.keymap.set({ "n", "v", "o" }, ":", ";")

-- reload config
vim.keymap.set("n", "<leader>r", '<cmd>luafile $MYVIMRC<CR>  <cmd>echo "reloaded"<CR>', { silent = true })

-- Clear highlights on search when pressing 2x <Esc> in normal mode
vim.keymap.set({ "n" }, "<Esc><Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set({ "n" }, "gb", "<cmd>ls<CR>:b<Space>")

function NetrwPop()
	local current_buffer = vim.api.nvim_win_get_buf(0)
	local windows = vim.api.nvim_tabpage_list_wins(0)
	local netrw_win = -1
	local netrw_buf = -1
	for _, win_id in ipairs(windows) do
		local buff_id = vim.api.nvim_win_get_buf(win_id)
		if vim.api.nvim_buf_is_loaded(buff_id) then
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buff_id })
			if ft == "netrw" then
				netrw_win = win_id
				netrw_buf = buff_id
				break
			end
		end
	end
	if netrw_win ~= -1 then
		if current_buffer ~= netrw_buf then
			vim.api.nvim_tabpage_set_win(0, netrw_win)
		elseif #windows > 1 then
			vim.api.nvim_win_close(netrw_win, false)
		end
	else
		local new_win = vim.api.nvim_open_win(0, true, { win = 0, split = "right", width=60 })
		if new_win then
			vim.api.nvim_win_call(new_win, function()
				vim.cmd("Explore .")
			end)
		end
	end
end
vim.api.nvim_create_user_command("Netrw", NetrwPop, {})
vim.keymap.set({ "n" }, "\\", NetrwPop)

-- change split sizes as arrows
vim.keymap.set("n", "<left>", "<C-W>5<")
vim.keymap.set("n", "<right>", "<C-W>5>")
vim.keymap.set("n", "<up>", "<C-W>5-")
vim.keymap.set("n", "<down>", "<C-W>5+")

-- autocommands
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 500, on_visual = false })
	end,
})
