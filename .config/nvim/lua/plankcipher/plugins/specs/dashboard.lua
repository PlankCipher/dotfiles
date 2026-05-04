return {
    dir = '~/.config/nvim/lua/plankcipher/plugins/local/dashboard',
    event = 'VeryLazy',
    config = function()
        local dashboard = require('dashboard')

        vim.keymap.set('n', '<leader>h', dashboard.bprevious)
        vim.keymap.set('n', '<leader>l', dashboard.bnext    )

        dashboard.setup({
            gap = 10,
            banner = {
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣶⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠛⠛⠿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣤⣤⣤⣤⣶⣶⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠋⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠛⠋⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⣿⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣉⣹⣿⣿⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣤⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⣄',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠻⠿⠿⠿⠛⠛⠛⠛⠛⠛⠛⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⡿⠋',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣾⣿⣿⡿⠿⠛⠋⠁⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣤⣶⣶⠿⠿⠟⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀',
                '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠒⠛⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
            },
            quotes = {
                {
                    'Sometimes all I wanna do is head west on 20',
                    "in a car I can't afford with a plan I don't have.",
                    'Just me, my music, and the road...',
                },
                {
                    'Even a broken clock is right twice a day',
                },
                {
                    'Shitty software everywhere',
                },
                {
                    '(( ) => {...})();',
                },
                {
                    'Do not go gentle into that good night',
                },
                {
                    'Saving people. Hunting things. The family business.',
                },
                {
                    "There ain't no me if there ain't no you",
                },
                {
                    'What the faculty have you done lately?',
                },
                {
                    'Kiss me. I love it.',
                },
                {
                    'for he is a friend to none, that is a friend to all',
                },
                {
                    "I mean, if life's so hard already, why do we bring more trouble down on ourselves?",
                    "What's up with the need to hit the self-destruct button?",
                    "Maybe we like the pain.",
                    "Maybe we're wired that way.",
                    "Because without it, I don't know...",
                    "...maybe we just wouldn't feel real.",
                    'What\'s that saying? "Why do I keep hitting myself with a hammer?"',
                    '"Because it feels so good when I stop."',
                },
                {
                    '... professionals who prescribe drugs they know little about',
                    'to cure diseases they know less about',
                    'for people they know nothing about ...',
                },
                {
                    'Nothing on the outside, nothing on the inside.',
                },
            },
        })
    end,
}
