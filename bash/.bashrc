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

if $CONFIG_ENABLE_DYNAMIC_EXEC; then
    mapfile -t scripts < <(LC_ALL=C printf '%s\n' ~/.bashrc.d/dynamic-exec.d/*.sh | LC_ALL=C sort)
    for script in "${scripts[@]}"; do
        [ -f "$script" ] && source "$script"
    done
fi