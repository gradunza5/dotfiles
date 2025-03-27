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
        'aklt/plantuml-syntax',
        ft = {
            "puml",
            "pu",
            "plantuml",
            "iuml",
            "wsd",
        },
    },
    {
        'tyru/open-browser.vim',
        ft = {
            "puml",
            "pu",
            "plantuml",
            "iuml",
            "wsd",
        },
    },
    {
        'weirongxu/plantuml-previewer.vim',
        ft = {
            "puml",
            "pu",
            "plantuml",
            "iuml",
            "wsd",
        },
    },
}
