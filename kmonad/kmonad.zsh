#!/usr/bin/env zsh

get_best_kbd() {
    # get the best keyboard for the current setup
    if [[ -e "/dev/input/by-id/usb-Chicony_HP_Elite_USB_Keyboard-event-kbd" ]]; then
        echo "CURRENT_KBD=/opt/kmonad/hp-elite-chicony.kbd" > /opt/kmonad/current_kbd
    elif [[ -e "/dev/input/by-id/usb-CHICONY_HP_Basic_USB_Keyboard-event-kbd" ]]; then
        echo "CURRENT_KBD=/opt/kmonad/hp-basic-chicony.kbd" > /opt/kmonad/current_kbd
    elif [[ -e "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ]]; then
        echo "CURRENT_KBD=/opt/kmonad/hp-elitebook.kbd" > /opt/kmonad/current_kbd
    else
        echo "No keyboard found"
        return 1
    fi
}

kmonad-restart() {
    get_best_kbd
    sudo systemctl restart kmonad.service
}
