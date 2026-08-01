local map = vim.keymap.set

-- Word count
map("n", "<leader>wc", "g<C-g>")

-- Clear search highlighting
map("n", "<Space>", "<cmd>nohlsearch<CR>")

-- Re-indent file
map("n", "<leader>i", "mzgg=G`z")

-- Copy text left of cursor onto new line
map("n", "<leader>o", 'v^yo<C-r>"')

-- Close help with escape
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function(ev)
        map("n", "<Esc>", "<C-w>c", { buf = ev.buf })
    end,
})

-- LSP stuff
map("n", "gd", vim.lsp.buf.definition, { desc="Go to definition"})
map("n", "gD", vim.lsp.buf.declaration, { desc="Go to declaration"})
map("n", "gi", vim.lsp.buf.implementation, { desc="Go to implementation"})
map("n", "grr", vim.lsp.buf.references, { desc="Go to references"})
map("n", "grn", vim.lsp.buf.rename, { desc="Rename symbol"})
map("n", "gca", vim.lsp.buf.code_action, { desc="Code action"})

--------------------------------------------------
-- Insert mode
--------------------------------------------------

map("i", "jk", "<Esc>")
map("i", "<C-CR>", "<Esc>o")
map("i", "<C-BS>", "<Esc>bcw")

--------------------------------------------------
-- Visual mode
--------------------------------------------------

map("v", "s", ":sort<CR>")
map("v", "<Down>", ":m '>+1<CR>gv=gv")
map("v", "<Up>", ":m '<-2<CR>gv=gv")

--------------------------------------------------
-- Arrow keys
--------------------------------------------------

map("n", "<Left>", "<cmd>tabprevious<CR>")
map("n", "<Right>", "<cmd>tabnext<CR>")

map("n", "<Up>", "<C-a>")
map("n", "<Down>", "<C-x>")

--------------------------------------------------
-- Misc
--------------------------------------------------

map("n", "s", "<C-w>")
map("n", "Y", "y$")
map({ "n", "o" }, "/", "/\\v")
map({ "n", "o" }, "?", "?\\v")
map("n", "Q", "<Nop>")
map("n", "H", "^")
map("n", "L", "$")

--Sudo write
map("c", "w!!", "w !sudo tee %")

map('t', '<Esc>', '<C-\\><C-n>', {noremap = true}) -- Easier to escape terminal mode

--------------------------------------------------
-- Extra text objects
--------------------------------------------------

for _, char in ipairs({ "_", "-", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", }) do
    map("x", "i" .. char, string.format(":<C-u>normal! T%svt%s<CR>", char, char), { silent = true })
    map("o", "i" .. char, string.format(":normal vi%s<CR>", char), { silent = true })
    map("x", "a" .. char, string.format(":<C-u>normal! F%svf%s<CR>", char, char), { silent = true })
    map("o", "a" .. char, string.format(":normal va%s<CR>", char), { silent = true })
end
