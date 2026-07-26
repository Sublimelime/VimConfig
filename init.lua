-- init.lua

--------------------------------------------------
-- OS detection
--------------------------------------------------

if vim.g.os == nil then
    if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1 then
        vim.g.os = "Windows"
    else
        vim.g.os = vim.fn.substitute(vim.fn.system("uname"), "\n", "", "")
    end
end

--------------------------------------------------
-- General
--------------------------------------------------

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
vim.cmd("cd ~")

local opt = vim.opt

opt.compatible = false
opt.relativenumber = true
opt.number = false
opt.confirm = true
opt.showmode = false
opt.title = true
opt.autoread = true
opt.autoindent = true
opt.ruler = true
opt.hidden = true
opt.lazyredraw = true
opt.showmatch = true
opt.concealcursor = "n"
opt.backup = false
opt.undofile = false
opt.exrc = true
opt.secure = true
opt.swapfile = false
opt.linebreak = true
opt.textwidth = 0
opt.showcmd = true
opt.scrolloff = 1
opt.switchbuf = { "useopen", "usetab" }
opt.cursorline = false
opt.sessionoptions = { "sesdir", "tabpages", "folds", "buffers", "resize", "winsize", "winpos", }
opt.timeoutlen = 1500
opt.ttimeout = true
opt.ttimeoutlen = 1500
opt.timeout = true
opt.updatetime = 700
opt.path:append("**")
opt.foldcolumn = "1"
opt.foldmethod = "indent"
opt.foldlevelstart = 99
opt.foldnestmax = 5
opt.modeline = false
opt.modelines = 1
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.ignorecase = true
opt.infercase = true
opt.smartcase = true
opt.incsearch = true
opt.magic = true
opt.hlsearch = true
opt.gdefault = true
opt.wildmenu = true
opt.wildignore = { ".zip", ".gz", ".exe", ".bin", ".odt", ".ods", }
opt.spelllang = { "en" }
opt.spell = false
opt.encoding = "utf-8"
opt.list = false
opt.listchars = { tab = "|." }
opt.synmaxcol = 1000
opt.laststatus = 2
opt.signcolumn = "yes"
opt.diffopt:append("iwhiteall")
vim.g.mapleader = "-"
vim.g.maplocalleader = "\\"
opt.background = "dark"
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- Fix nvim terminal when running in powershell
if vim.g.os == "Windows" then
    local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

-- Neovide config options
if vim.g.neovide then
    vim.o.guifont = "Cascadia Mono:h10"
    vim.g.neovide_theme = 'dark'
end


--------------------------------------------------
-- User Commands
--------------------------------------------------

vim.api.nvim_create_user_command("Scratch", function()
    vim.cmd("new")
    vim.opt_local.buftype = "nofile"
    vim.opt_local.bufhidden = "wipe"
    vim.opt_local.swapfile = false
    vim.opt_local.buflisted = false
end, {})

--------------------------------------------------
-- SearchOpen
--------------------------------------------------

local function search_open_files(pattern)
    local files = {}

    for i = 1, vim.fn.bufnr("$") do
        if vim.fn.buflisted(i) == 1 then
            table.insert(files, vim.fn.fnameescape(vim.fn.bufname(i)))
        end
    end

    if #files == 0 then
        return
    end

    local ok = pcall(function()
        vim.cmd(
            ("silent noautocmd vimgrep /%s/gj %s")
            :format(pattern, table.concat(files, " "))
        )
    end)

    if not ok then
        vim.notify("No match found.")
    end

    vim.cmd("botright cwindow")
end

vim.api.nvim_create_user_command("SearchOpen", function(opts)
    search_open_files(opts.args)
end, { nargs = 1 })

--------------------------------------------------
-- StripWhitespace
--------------------------------------------------

local function strip_whitespace()
    local search = vim.fn.getreg("/")
    local pos = vim.api.nvim_win_get_cursor(0)

    vim.cmd([[silent! %s/\v\s+$//e]])
    vim.cmd([[silent! %s/\v($\n\s*)+\%$//]])
    vim.cmd([[silent! %s/\v^\n{3,}/\r\r/]])

    vim.fn.setreg("/", search)
    vim.api.nvim_win_set_cursor(0, pos)

    print("Cleaned whitespace.")
end

vim.api.nvim_create_user_command("StripWhitespace", strip_whitespace, {})

--------------------------------------------------
-- Misc commands
--------------------------------------------------

vim.api.nvim_create_user_command("DiffOrig", function()
    vim.cmd("vert new")
    vim.cmd("set bt=nofile")
    vim.cmd("r #")
    vim.cmd("0d_")
    vim.cmd("diffthis")
    vim.cmd("wincmd p")
    vim.cmd("diffthis")
end, {})

vim.api.nvim_create_user_command("ForceQuit", function()
    vim.cmd("bufdo setlocal nomodified")
    vim.cmd("q!")
end, {})

--------------------------------------------------
-- Grep
--------------------------------------------------

if vim.fn.executable("rg") == 1 then
    opt.grepprg = "rg"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

--------------------------------------------------
-- Source additional config
--------------------------------------------------

require("keybinds")
require("abbrevs")
require("plugins")

--------------------------------------------------
-- Autocommands
--------------------------------------------------

local misc = vim.api.nvim_create_augroup("misc", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = misc,
    pattern = "vim",
    command = "setlocal foldmethod=marker",
})

vim.api.nvim_create_autocmd("FileType", {
    group = misc,
    pattern = "conf",
    command = "setlocal nowrap foldmethod=marker",
})

vim.api.nvim_create_autocmd("FileType", {
    group = misc,
    pattern = "gitcommit",
    command = "setlocal nobackup noswapfile",
})

vim.api.nvim_create_autocmd("FileType", {
    group = misc,
    pattern = "help",
    command = "setlocal nospell",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = misc,
    callback = strip_whitespace,
})

-- Diagnostics on cursor pause
local diagnostic_group = vim.api.nvim_create_augroup("diagnostic_hover", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    group = diagnostic_group,
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = {
                "BufLeave",
                "CursorMoved",
                "InsertEnter",
                "FocusLost",
            },
            border = "rounded",
            source = "if_many",
            prefix = "",
            scope = "cursor",
        })
    end,
})

--------------------------------------------------
-- Number toggle
--------------------------------------------------

local number_toggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })

local function relative_numbers()
    vim.opt_local.relativenumber = true
    vim.opt_local.number = false
end

local function absolute_numbers()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
end

vim.api.nvim_create_autocmd("InsertEnter", {
    group = number_toggle,
    callback = absolute_numbers,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = number_toggle,
    callback = relative_numbers,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = number_toggle,
    callback = absolute_numbers,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = number_toggle,
    callback = relative_numbers,
})
