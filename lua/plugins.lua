-- Vim pack calls


vim.pack.add({
  { src = 'https://github.com/windwp/nvim-autopairs', name = 'Autopairs' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'Lualine' },
  { src = 'https://github.com/neanias/everforest-nvim', name = 'Everforest' },
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
