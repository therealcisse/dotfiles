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
        'terminfo',
        'nvim',
        'automator',
        'defaults',
      ],
      variables: {},
    },
    linux: {
      aspects: [

      ],
      variables: {},
    },
    'linux.debian': {
      aspects: [
      ],
      variables: {},
    },
  },
  profiles: {
    codespaces: {
      pattern: '/codespaces/i',
      variables: {
        gitMergeConflictStyle: 'diff3',
      },
    },
    personal: {
      pattern: '/^(?:retiro|huertas)(?:\\b|$)/i',
      variables: {
        corpusNotes: '~/Sync/Personal/Corpus',
      },
    },
    work: {
      pattern: '/^gregorys-mbp(?:\\b|$)/i',
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
