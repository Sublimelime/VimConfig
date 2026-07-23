-- Vim pack calls


vim.pack.add({
  { src = 'https://github.com/windwp/nvim-autopairs', name = 'Autopairs' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'Lualine' },
  { src = 'https://github.com/neanias/everforest-nvim', name = 'Everforest' },
  { src = 'https://github.com/nvim-lua/plenary.nvim', name = 'Plenary' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'Telescope' },
  { src = 'https://github.com/linux-cultist/venv-selector.nvim', name = 'VenvSelector' },
  { src = 'https://github.com/neovim/nvim-lspconfig', name = "LSPConfig"},
  { src = 'https://github.com/nvim-mini/mini.align', version = 'stable', name = "MiniAlign" },
})


-- Configs and setup ------------------------------------------------------

require("nvim-autopairs").setup({ map_bs = false, map_cr = false })

require("everforest").setup({ background = "hard" })
require("everforest").load()

require('lualine').setup {
    options = {
        theme = 'everforest',
        icons_enabled = false,
        globalstatus = true,
        section_separators = '',
        component_separators = ''
    },
    sections = {
        -- [abc]defghijklmnopqrstuvw[xyz]
        -- using lualine_? configures that position above
        -- [] are used already
        lualine_w = {{ 'searchcount', maxcount = 500, timeout = 500, }}
    }
}

require('mini.align').setup()


require('telescope').setup()
local tele = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tele.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', tele.git_branches, { desc = 'Telescope git branches' })
vim.keymap.set('n', '<leader>b', tele.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tele.help_tags, { desc = 'Telescope help tags' })

require('venv-selector').setup()

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
vim.lsp.enable('pyright')
