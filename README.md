This repo provides basic and fairly makeshift implementations for launching apps, files and directories. Drop it into `FZS_ROOT_DIR` and it should work. Please raise an issue if it doesn't.
You may wish to look over each file to customize it to your liking (i.e. Choose which directories are available to `peek.peek`), or edit the filenames to create aliases and descriptions.

- Compatible with both mac and linux.
- Requires fzf
  - Window selector on mac requires yabai
  - bat is used for display. (You may wish to replace it with cat if it's not available).
  - You may want to set FZF_DEFAULT_OPTS to make better use of the file/directory selection, ([See](https://github.com/Squirreljetpack/fzs#Usage tips)).

# Previews

##### dir

<img src=".README.assets/directory.png" alt="directory" style="zoom: 50%;" /> 

##### app

<img src=".README.assets/app.png" alt="app" style="zoom:50%;" />

