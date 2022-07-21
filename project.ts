export default {
    platforms: {
        darwin: {
            aspects: [
                'dotfiles',
                'fonts',
                'homebrew',
                'iterm',
                'node',
                'karabiner',
                'launchd',
                'shell',
                'ssh',
                'cron',
                'terminfo',
                'nvim',
                'automator',
                'defaults',
            ],
            variables: {},
        },
        linux: {
            aspects: [
                'sshd',
                'locale',
                'systemd',
                'interception',
                'dotfiles',
                'fonts',
                'node',
                'shell',
                'cron',
                'ssh',
                'terminfo',
                'nvim',
            ],
            variables: {},
        },
        'linux.debian': {
            aspects: [
                ['apt', 'dotfiles', 'shell', 'node'],
                ['nvim'],
            ],
            variables: {},
        },
    },
    profiles: {
        personal: {
            pattern: '/^(?:amadous-mbp)(?:\\b|$)/i',
            variables: {},
        },
        work: {
            pattern: '/^QV3F6LQ19R-acisse(?:\\b|$)/i',
            variables: {},
        },
    },
    variables: {
        corpusNotes: '~/Documents/Corpus',
        figManaged:
        'vim: set nomodifiable : DO NOT EDIT - edit template source instead or use `:set modifiable` to force.',
        gitCipherPath: 'vendor/git-cipher/bin/git-cipher',
        gitMergeConflictStyle: 'zdiff3',
        iTermDynamicProfiles: {
            external: [
                {
                    path: 'Vim.json',
                    src: '70-Vim-4K.json',
                },
            ],
            retina: [
                {
                    path: 'Vim.json',
                    src: '70-Vim-Retina.json',
                },
            ],
        },
    },
};
