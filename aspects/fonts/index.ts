import {command, file, log, path, resource, skip, task} from 'fig';
import stat from 'fig/fs/stat.js';

task('create ~/Library/Fonts', async () => {
  await file({
    path: path.home.join('Library/Fonts'),
    state: 'directory',
  });
});

task('install iosevka', async () => {
  // Check to see whether submodule is present.
  const contents = 'vendor/fonts/ttc-iosevka-15';

  const stats = await stat(contents);

  if (stats === null) {
    await log.warn(`Submodule contents missing at "${contents}"`);

    return await skip();
  } else if (stats instanceof Error) {
    throw stats;
  }

  const files = resource.files('iosevka/*.ttc');

  const target = path.home.join('Library/Fonts');

  for (const ttc of files) {
    await command('cp', [ttc, target], {
      creates: target.join(ttc.basename),
    });
  }
});

task('install JetBrains Mono', async () => {
  // Check to see whether submodule is present.
  const contents = 'vendor/fonts/JetBrainsMono-1.0.3/TTF';

  const stats = await stat(contents);

  if (stats === null) {
    await log.warn(`Submodule contents missing at "${contents}"`);

    return await skip();
  } else if (stats instanceof Error) {
    throw stats;
  }

  const files = resource.files('jetbrains-mono/*.ttf');

  const target = path.home.join('Library/Fonts');

  for (const ttf of files) {
    await command('cp', [ttf, target], {
      creates: target.join(ttf.basename),
    });
  }
});

task('install Hack', async () => {
  // Check to see whether submodule is present.
  const contents = 'vendor/fonts/Hack';

  const stats = await stat(contents);

  if (stats === null) {
    await log.warn(`Submodule contents missing at "${contents}"`);

    return await skip();
  } else if (stats instanceof Error) {
    throw stats;
  }

  const files = resource.files('hack-mono/*.ttf');

  const target = path.home.join('Library/Fonts');

  for (const ttf of files) {
    await command('cp', [ttf, target], {
      creates: target.join(ttf.basename),
    });
  }
});

task('install Source Code Pro', async () => {
  // Check to see whether submodule is present.
  const contents = 'vendor/fonts/source-code-pro';

  const stats = await stat(contents);

  if (stats === null) {
    await log.warn(`Submodule contents missing at "${contents}"`);

    return await skip();
  } else if (stats instanceof Error) {
    throw stats;
  }

  const files = resource.files('source-code-pro/*.ttf');

  const target = path.home.join('Library/Fonts');

  for (const ttf of files) {
    await command('cp', [ttf, target], {
      creates: target.join(ttf.basename),
    });
  }
});
