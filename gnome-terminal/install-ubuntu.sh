apt-get install -y gnome-terminal

mkdir -p $HOME/.dir_colors
ln -s $PWD/dircolors $HOME/.dir_colors/dircolors

dconfdir=/org/gnome/terminal/legacy/profiles:

# make new profile
profile_ids_old="$(dconf read "$dconfdir"/list | tr -d "]")"
profile_id="$(uuidgen)"

dconf write $dconfdir/list \
    "${profile_ids_old}, '$profile_id']"
dconf write "$dconfdir/:$profile_id"/visible-name "'Dracula'"


profile_dir="$dconfdir/:$profile_id"

# make sure the profile is set to not use theme colors
dconf write $profile_dir/use-theme-colors "false"

# set highlighted color to be different from foreground color
dconf write $profile_dir/bold-color-same-as-fg "false"

# set foreground, background and highlight color
dconf write $profile_dir/bold-color "'$(cat $PWD/bd_color)'"
dconf write $profile_dir/background-color "'$(cat $PWD/bg_color)'"
dconf write $profile_dir/foreground-color "'$(cat $PWD/fg_color)'"

# set as default profile
dconf write $dconfdir/default "'$profile_id'"


to_dconf() {
    tr '\n' '~' | sed -e "s#~\$#']\n#" -e "s#~#', '#g" -e "s#^#['#"
}

# set color palette
dconf write $profile_dir/palette "$(to_dconf < $PWD/palette)"


