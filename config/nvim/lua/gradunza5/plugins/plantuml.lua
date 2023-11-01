return {
    {
        'https://gitlab.com/itaranto/plantuml.nvim',
        ft = {
            "puml",
            "pu",
            "plantuml",
            "iuml",
            "wsd",
        },
        version = '*',
        config = function()
            require('plantuml').setup {
                renderer = {
                    type = 'image',
                    options = {
                        prog = '~/imgcat.sh',
                        dark_mode = true,
                    }
                },
            }
        end,
    },
    {
        'aklt/plantuml-syntax'
    },
    {
        'tyru/open-browser.vim'
    },
    {
        'weirongxu/plantuml-previewer.vim'
    },
}
