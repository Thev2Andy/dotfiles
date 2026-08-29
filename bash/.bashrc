# ╭───────── .bashrc Configuration ────────╮
# ├────────────────────────────────────────┤
# │ yes ikr it's overkill shut the fuck up │
# ╰────────────────────────────────────────╯

# If not running interactively, source the non-interactive module and stop.
if [[ $- != *i* ]]; then
    source ~/.bashrc.d/noninteractive
    return
fi

CONFIG_ENABLE_DYNAMIC_EXEC=true

source ~/.bashrc.d/aliases
source ~/.bashrc.d/path
source ~/.bashrc.d/prompt

# Optionally source untracked overrides module.
if [ -f "$HOME/.bashrc.d/overrides" ]; then
    source $HOME/.bashrc.d/overrides
fi

# Dynamically execute scripts in dynamic-exec.d
if $CONFIG_ENABLE_DYNAMIC_EXEC; then
    mapfile -t scripts < <(LC_ALL=C printf '%s\n' ~/.bashrc.d/dynamic-exec.d/* | LC_ALL=C sort)
    for script in "${scripts[@]}"; do
        [[ -f "$script" && -x "$script" ]] && "$script"
    done
fi