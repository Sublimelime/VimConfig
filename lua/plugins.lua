-- Vim pack calls


vim.pack.add({
    { src = 'https://github.com/windwp/nvim-autopairs', name = 'Autopairs' },
    { src = 'https://github.com/windwp/nvim-ts-autotag', name = 'Autotag' }, -- For html tag autoclose
    { src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'Lualine' },
    { src = 'https://github.com/ember-theme/nvim', name = 'Ember' },
    { src = 'https://github.com/nvim-lua/plenary.nvim', name = 'Plenary' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'Telescope' },
    { src = 'https://github.com/linux-cultist/venv-selector.nvim', name = 'VenvSelector' },
    { src = 'https://github.com/neovim/nvim-lspconfig', name = "LSPConfig"},
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', name = "Treesitter"},
    { src = 'https://github.com/nvim-mini/mini.align', version = 'stable', name = "MiniAlign" },
    { src = 'https://github.com/nvim-mini/mini.completion', version = 'stable', name = "MiniComplete" },
    { src = 'https://github.com/tpope/vim-fugitive', name = "Fugitive"},
    { src = 'https://github.com/mason-org/mason.nvim', name = "Mason"},
})

-- Color scheme
vim.cmd.colorscheme("ember")

-- Configs and setup ------------------------------------------------------

require("nvim-autopairs").setup({ map_bs = false, map_cr = false })

require('lualine').setup {
    options = {
        theme = 'gruvbox-material',
        icons_enabled = false,
        globalstatus = true,
        section_separators = '',
        component_separators = ''
    },
    -- sections = {
    --     -- [abc]defghijklmnopqrstuvw[xyz]
    --     -- using lualine_? configures that position above
    --     -- [] are used already
    -- }
}

require('mini.align').setup()

require('mini.completion').setup()
-- Enables tab to navigate completion
local imap_expr = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

require('telescope').setup()
local tele = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tele.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', tele.git_branches, { desc = 'Telescope git branches' })
vim.keymap.set('n', '<leader>b', tele.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tele.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fs', tele.lsp_workspace_symbols, { desc = 'Telescope lsp symbols' })

require('venv-selector').setup()

require("nvim-ts-autotag").setup()

--------------------------------------------------------------------------------------
--- LSP Configs
------------------------------------------------------------------------------
-- Mason first
require("mason").setup()

-- Only shows underlines for errors, not warnings
vim.diagnostic.config({
    underline = {
        severity = vim.diagnostic.severity.ERROR,
    },
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.WARN,
        },
        spacing = 2,
    },
    signs = true,
})

local npm_root = vim.fn.trim(vim.fn.system("npm root -g"))
vim.lsp.config("vue_ls", {
    init_options = {
        typescript = {
            tsdk = npm_root .. "/typescript/lib",
        },
    },
})

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = npm_root .. '/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
}
vim.lsp.config('vtsls', {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.enable("vtsls")
vim.lsp.enable('vue_ls')

-- Python
vim.lsp.config('pyrefly', {
    settings = {
        python = {
            pyrefly = {
                typeCheckingMode = 'default',
                analysis = {
                    showHoverGoToLinks = false,
                },
            },
        }
    }
})
vim.lsp.enable('pyrefly')

-- Tailwind
vim.lsp.config("tailwindcss", {
    settings = {
        tailwindCSS = {
            colorDecorators = true,
        },
    },
})
vim.lsp.enable("tailwindcss")

-- Treesitter
vim.env.CC = vim.fn.exepath("clang")
require('nvim-treesitter').install { 'vue', 'python', 'typescript', 'lua', 'javascript', 'html' }
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'python', 'typescript', 'vue', 'html' },
    callback = function()
        vim.treesitter.start()
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
