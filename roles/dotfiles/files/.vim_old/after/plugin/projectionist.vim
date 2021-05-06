let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \
      \     '*.js': {
      \       'alternate': [
      \         '{dirname}/{basename}.test.js',
      \         '{dirname}/__tests__/{basename}-test.js',
      \         '{dirname}/__tests__/{basename}-mocha.js'
      \       ],
      \       'type': 'source'
      \     },
      \     '*.test.js': {
      \       'alternate': '{basename}.js',
      \       'type': 'test',
      \     },
      \     '**/__tests__/*-mocha.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \     '**/__tests__/*-test.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     },
      \    'src/main/java/*.java': {
      \       'alternate': 'src/test/java/{}.java'
      \     },
      \     'src/test/java/*.java': {
      \       'alternate': 'src/main/java/{}.java'
      \     },
      \    'src/main/java/*.scala': {
      \       'alternate': 'src/test/java/{}.scala'
      \     },
      \     'src/test/java/*.scala': {
      \       'alternate': 'src/main/java/{}.scala'
      \     }
      \   }
\ }
