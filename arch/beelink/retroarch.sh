#!/usr/bin/env bash

HOME_PATH='/home/retro'

mkdir --parents "${HOME_PATH}/.config/retroarch/autoconfig"

cat /dev/null > '/etc/retroarch.cfg'

cat << EOF > "${HOME_PATH}/.config/retroarch/retroarch.cfg"
autosave_interval = "600"
config_save_on_exit = "false"
core_info_cache_enable = "false"
keyboard_gamepad_enable = "false"
libretro_directory = "${HOME_PATH}/.config/retroarch/cores"
libretro_info_path = "${HOME_PATH}/.config/retroarch/cores/info"
menu_driver = "rgui"
savefile_directory = "${HOME_PATH}/saves"
savefiles_in_content_dir = "false"
savestate_directory = "${HOME_PATH}/states"
savestates_in_content_dir = "false"
system_directory = "${HOME_PATH}/system"
systemfiles_in_content_dir = "false"
video_driver = "vulkan"
EOF

cat << 'EOF' > "${HOME_PATH}/.config/retroarch/autoconfig/Microsoft X-Box 360 pad.cfg"
input_driver = "udev"

input_device = "Microsoft X-Box 360 pad"
input_product_id = "654"
input_vendor_id = "1118"

input_a_btn = "1"
input_b_btn = "0"
input_down_btn = "h0down"
input_gun_trigger_mbtn = "1"
input_l_btn = "4"
input_l_x_minus_axis = "-0"
input_l_x_plus_axis = "+0"
input_l_y_minus_axis = "-1"
input_l_y_plus_axis = "+1"
input_l2_axis = "+2"
input_l3_btn = "9"
input_left_btn = "h0left"
input_r_btn = "5"
input_r_x_minus_axis = "-3"
input_r_x_plus_axis = "+3"
input_r_y_minus_axis = "-4"
input_r_y_plus_axis = "+4"
input_r2_axis = "+5"
input_r3_btn = "10"
input_right_btn = "h0right"
input_select_btn = "6"
input_start_btn = "7"
input_up_btn = "h0up"
input_x_btn = "3"
input_y_btn = "2"

input_enable_hotkey_btn = "8"
input_exit_emulator_btn = "7"
input_load_state_btn = "4"
input_menu_toggle_btn = "3"
input_reset_btn = "0"
input_save_state_btn = "5"
input_state_slot_decrease_btn = "h0left"
input_state_slot_increase_btn = "h0right"
EOF

# Cores
curl --location --output "${HOME_PATH}/RetroArch_cores.7z" --silent 'https://buildbot.libretro.com/stable/1.10.3/linux/x86_64/RetroArch_cores.7z'

7za e -o"${HOME_PATH}/.config/retroarch/cores" "${HOME_PATH}/RetroArch_cores.7z"

find "${HOME_PATH}/.config/retroarch/cores" -type d -delete 2>/dev/null

# Core Information
git clone --depth 1 --filter blob:none --sparse 'https://github.com/libretro/libretro-super'

cd 'libretro-super'

git sparse-checkout set 'dist/info'

cp --archive --verbose 'dist/info' "${HOME_PATH}/.config/retroarch/cores/"

# Permissions
chmod 0444 '/etc/retroarch.cfg'

chmod 0440 "${HOME_PATH}/.config/retroarch/retroarch.cfg" "${HOME_PATH}/.config/retroarch/autoconfig/Microsoft X-Box 360 pad.cfg"

find "${HOME_PATH}/.config/retroarch/cores" -type f -print0 | xargs -0 chmod 0440
find "${HOME_PATH}/.config/retroarch/cores" -type d -print0 | xargs -0 chmod 0550
