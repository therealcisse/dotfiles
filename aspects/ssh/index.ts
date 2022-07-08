import {
  fail,
  file,
  helpers,
  path,
  resource,
  skip,
  task,
  template,
  variable,
} from 'fig';
import stat from 'fig/fs/stat.js';

const {when} = helpers;

task('create ~/.ssh/* directories', async () => {
  for (const directory of [
    '~/.ssh',
    '~/.ssh/config.d',
    '~/.ssh/config.d/post',
    '~/.ssh/config.d/pre',
  ]) {
    await file({
      mode: '0700',
      path: directory,
      state: 'directory',
    });
  }
});

task('create ~/.ssh', async () => {
  await file({
    mode: '0700',
    path: '~/.ssh',
    state: 'directory',
  });
});


