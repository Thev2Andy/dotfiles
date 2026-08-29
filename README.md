<div align="center">
<h1><img alt="niri" src="https://github.com/user-attachments/assets/07d05cd0-d5dc-4a28-9a35-51bae8f119a0" style="width: 56px"> dotfiles</h1>
My personal daily driver setup running on <b>Arch Linux</b>.<br/>
(<i>i use arch btw🥀💔</i>)<br/>
dotfiles are distro-agnostic fyi
</div>

## Screenshots
<table>
  <tr>
    <td width="50%"><img src="./.git-assets/1.png" alt="Floating Windows"/></td>
    <td width="50%"><img src="./.git-assets/2.png" alt="Overview"/></td>
  </tr>
  <tr>
    <td width="50%"><img src="./.git-assets/3.png" alt="Task Manager"/></td>
    <td width="50%"><img src="./.git-assets/4.png" alt="Bar System Center"/></td>
  </tr>
  <tr>
    <td width="50%"><img src="./.git-assets/5.png" alt="Code Editor"/></td>
    <td width="50%"><img src="./.git-assets/6.png" alt="Tmux"/></td>
  </tr>
</table>

## Included
- Modular `.bashrc` with dynamic script loading
- Kitty configuration with included theme
- Modular niri configuration
- Noctalia configuration
- Oh-My-Posh prompt configuration

## **NOT** Included
- Wallpapers
- Fonts
- VSCode Theme (shameless plug: [future-dark-vscode](https://github.com/Thev2Andy/future-dark-vscode))

## Dependencies
- Niri, Noctalia, Bash (_obviously.._)
- Fonts: JetBrainsMono Nerd Font, Inter Font
- Integrated but optional: `fastfetch`, `oh-my-posh`, `bat`
- Spawned at startup: `easyeffects`, `oniri`, `wayland-pipewire-idle-inhibit`

## Configuration Overrides
### Applications
By default, the following apps are used for binds: Kitty (`kitty`), Nautilus (`nautilus --new-window`), Firefox (`firefox`), VSCode (`code`), OBS Studio (with `obs-cmd`), as configured in [`niri/apps.default.json`](niri/.config/niri/apps.default.json).<br/>
However, they are abstracted by a bash script inside niri's configuration, such that they can be overridden in an `apps.override.json` file dropped in `~/.config/niri`.
```json
{
    "terminal": "kitty",
    "files": "nautilus --new-window",
    "browser": "firefox",
    "editor": "code",
    "ipc-instant-replay": "obs-cmd replay save",
    "custom-valid": "your-binary-here"
}
```
It may also be helpful to copy the default file to have a schema for overrides.
```sh
cp ~/.config/niri/apps.default.json ~/.config/niri/apps.override.json
```
It is also possible to add your own keys to `apps.override.json`, however invoking them with no configuration file present will have no defaults.
```sh
./launch-app.sh custom-valid
# executes key 'custom-valid' from apps.json

./launch-app.sh custom-invalid
[Launch Error]
Failed to launch application!
Unknown app key: custom-invalid
```

### Niri
Outputs can be configured in `~/.config/niri/outputs.kdl`.<br/>
Overrides can be put in `~/.config/niri/overrides.kdl` and are applied at the very end, even after Noctalia's own configuration files.<br/>
Binds and startup programs may require to be set as `skip-worktree` in git as to not override your tweaks when pulling.
```sh
git update-index --skip-worktree niri/.config/niri/{binds,startup}.kdl
```

### Noctalia
Noctalia overrides are configured in the settings menu, opened with <kbd>Ctrl</kbd>+<kbd>Comma</kbd> as per the default keybinds.

### Bash Configuration (`.bashrc` & `.bashrc.d`)
Bash configuration can be overridden in `.bashrc.d/overrides` (sourced into `.bashrc`) and can modify shell settings.
```bash
# Configurable: Disable dynamic scripts
CONFIG_ENABLE_DYNAMIC_EXEC=false

# Proof-of-Concept: Tweak default globbing settings (usually a bad idea btw)
shopt -s nullglob
shopt -s dotglob
```
Additionally, scripts may be placed in `.bashrc.d/dynamic-exec.d/` and ran automatically. (`10-foo.sh` may be executed before `99-bar.sh`)<br/>
This is currently used to run `fastfetch` on startup in [`.bashrc.d/dynamic-exec.d/99-fastfetch.sh`](bash/.bashrc.d/dynamic-exec.d/99-fastfetch.sh).

## Cloning & Setup
clone the repo and stow the packages gang it genuinely can't be that hard😭🙏
```sh
cd ~
git clone https://github.com/Thev2Andy/dotfiles.git .dotfiles
cd .dotfiles
for d in */; do stow --no-folding -t ~ "${d%/}"; done
```
\* Requires GNU stow (`stow`)<br/>
\* It is preferred to use `--no-folding` as to allow writing overrides completely untracked by the cloned repository.

___

"_i have dotglobbing enabled, your stow command put `.git` and `.git-assets` into my home folder_"<br/>
<img src="./.git-assets/boar-exploding-head.png" alt="boar exploding head" title="that's crazy maybe don't run dotglobbing?🥀😭🙏" style="width: 128px"><br/>
(hover the image)

### Unstowing accidentaly stowed hidden folders
```sh
for d in .*/; do stow -D -t ~ "${d%/}"; done
```
fyi ironically enough if you know how to modify your globbing settings you should know how to run stow on packages but that's just me tbh🥀 maybe read a manpage or two😭🙏💔