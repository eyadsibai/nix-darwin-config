#!/bin/bash

SPACE_SIDS=$(/opt/homebrew/bin/aerospace list-workspaces --all);

sketchybar --add event aerospace_workspace_change


for sid in "${SPACE_SIDS[@]}"
do
  sketchybar --add space space.$sid left \
          --subscribe space.$sid aerospace_workspace_change \
                                 \
             --set space.$sid                                \
                              icon=$sid                                  \
                              label.font="sketchybar-app-font:Regular:14.0" \
                              label.padding_right=20                     \
                              label.y_offset=-1                          \
                              script="$PLUGIN_DIR/space.sh"             \
                              click_script="/opt/homebrew/bin/aerospace workspace $sid"               
done

sketchybar --add item space_separator left             \                \
           --set space_separator icon="􀆊"                                \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4                   \
                                 label.drawing=off                     \
                                 background.drawing=off                \
                                 script="$PLUGIN_DIR/space_windows.sh" \
           --subscribe space_separator space_windows_change                           
