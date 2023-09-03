import {
  command,
  cron,
  file,
  helpers,
  path,
  resource,
  template,
  task,
} from 'fig';

const {when} = helpers;

task('create ~/Library/Cron', when('therealcisse', 'personal'), async () => {
  await file({
    path: '~/Library/Cron',
    state: 'directory',
  });
});

task('fill templates', when('therealcisse', 'personal'), async () => {
  for (const src of resource.templates('*.erb')) {
    await template({
      mode: '0755',
      path: path('~/Library/Cron').join(src.basename.strip('.erb')),
      src,
    });
  }
});

