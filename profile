# Working with colors:
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
#
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

function mkcd() {
  mkdir "$1"
  cd "$1" > /dev/null
  echo -e "\e$BGreen Created\e$Color_Off `realpath ..`/\e$BBlue`basename $(pwd)`\e$Color_Off"
}

# .oh-my-zsh/lib/directories.sh creates an alias for 'l' by default
# This disables it
# unalias l
function l() {
  eza -alhmF --git --group-directories-first $1
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function e() {
  code ${1:-.}
}

function p() {
  p=`realpath ${1:-.}`
  echo -e "`realpath $p/..`/\e$BBlue`basename $p`\e$Color_Off"
}

function cd() {
  HOME=~/Code builtin cd -P "$@" > /dev/null
  p
}

alias activate="source venv/bin/activate"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
# alias dj="python manage.py"
# alias djr="python manage.py runserver"
alias dj="uv run manage.py"
alias djr="uv run manage.py runserver"
alias djs="uv run manage.py shell"
alias djt="uv run pytest"
alias g="git"
alias ga="git add"
alias gac="git commit -am"
alias gst="git status"
alias gc="git commit -m "
alias gl="git l"
alias gll="git ll"
alias hk="heroku"
alias ip="ipython"
alias nb="jupyter notebook"
alias server="python3 -m http.server"
alias s="server"
alias t="eza -l --git --group-directories-first -T"
alias uvr="uv run"
alias vim="nvim"

# alias sync-photos="rsync -r '/Volumes/NIKON D7000/DCIM' /Volumes/Media/Photos/RAW/d7000 --progress -h"
# alias backup-sd-card="/usr/bin/time -hp rsync -rh -t --progress --stats '/Volumes/NIKON D7000/DCIM' cody@jupiter.local:/volume1/Photos/RAW/d7000 && date && diskutil eject 'NIKON D7000'"
# backup_sd_card() {
#     local source_dir="/Volumes/NIKON D7000/DCIM"
#     local destination_dir="cody@jupiter.local:/volume1/Photos/RAW/d7000"
#     local log_file="$HOME/backup_sd_card.log"
#     local sd_card_volume="/Volumes/NIKON D7000"

#     # Check if the SD card is inserted
#     [[ ! -d "$sd_card_volume" ]] && { echo "Error: SD card not found. Please insert the SD card and try again." | tee -a "$log_file"; return 1; }

#     echo "Starting backup at $(date)" | tee -a "$log_file"

#     # Perform rsync and log the output
#     /usr/bin/time -hp rsync -rh -t --progress --stats "$source_dir" "$destination_dir" 2>&1 | tee -a "$log_file"
#     [[ ${PIPESTATUS[0]} -ne 0 ]] && { echo "Error: rsync failed. Check the log for details." | tee -a "$log_file"; return 1; }

#     date | tee -a "$log_file"
    
#     # Eject the SD card
#     diskutil eject 'NIKON D7000' || { echo "Error: Failed to eject the SD card." | tee -a "$log_file"; return 1; }

#     echo "Backup completed successfully at $(date)" | tee -a "$log_file"
# }

backup_sd_card() {
    local log_file="$HOME/backup_sd_card.log"

    # --- Nikon Z5_2 paths ---
    local z5_volume="/Volumes/NIKON Z5_2 " # Note the trailing space
    local z5_source_dir="$z5_volume/DCIM"
    local z5_destination_dir="cody@jupiter.local:/volume1/Photos/RAW/z5_2"

    # --- Nikon D7000 paths ---
    local d7000_volume="/Volumes/NIKON D7000"
    local d7000_source_dir="$d7000_volume/DCIM"
    local d7000_destination_dir="cody@jupiter.local:/volume1/Photos/RAW/d7000"

    # Detect which card is present (Z5_2 first, then D7000)
    local source_dir=""
    local destination_dir=""
    local sd_card_volume=""

    if [[ -d "$z5_volume" ]]; then
        source_dir="$z5_source_dir"
        destination_dir="$z5_destination_dir"
        sd_card_volume="$z5_volume"
    elif [[ -d "$d7000_volume" ]]; then
        source_dir="$d7000_source_dir"
        destination_dir="$d7000_destination_dir"
        sd_card_volume="$d7000_volume"
    else
        echo "Error: No supported SD card found. Insert either the Nikon Z5_2 or D7000 card." | tee -a "$log_file"
        return 1
    fi

    echo "Starting backup at $(date)" | tee -a "$log_file"

    /usr/bin/time -hp rsync -rh -t --progress --stats "$source_dir" "$destination_dir" 2>&1 | tee -a "$log_file"
    if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
        echo "Error: rsync failed. Check the log for details." | tee -a "$log_file"
        return 1
    fi

    date | tee -a "$log_file"

    diskutil eject "$sd_card_volume" || {
        echo "Error: Failed to eject the SD card." | tee -a "$log_file"
        return 1
    }

    echo "Backup completed successfully at $(date)" | tee -a "$log_file"
}

alias check-photo-backups='/Users/codyfuller/.pyenv/versions/py-sandbox/bin/python /Users/codyfuller/Code/sandbox/backup-jupiter-photos/check_latest_versions.py'

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export CDPATH="$HOME/Code"

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var repoDir $(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
}

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


pyenv-new() {
  local python_version=$1
  local env_name=$2

  # Check if the python version is installed
  if ! pyenv versions | grep -q "$python_version"; then
    echo "Error: Python version $python_version is not installed."
    return 1
  fi

  # Create the virtual environment
  pyenv virtualenv $python_version $env_name

  # Set the local pyenv version to the new virtual environment
  pyenv local $env_name

  echo "Virtual environment $env_name created and set as the local pyenv version."
}

wake_marvin() {
    local MAC_ADDRESS="70:85:c2:f9:3d:32"
    
    # Get the broadcast address dynamically
    local BROADCAST_ADDRESS=$(ifconfig en0 | awk '/inet /{print $6}')

    # Fall back to 10.10.10.255 if BROADCAST_ADDRESS is empty or invalid
    if [[ -z "$BROADCAST_ADDRESS" ]]; then
        BROADCAST_ADDRESS="10.10.10.255"
    fi

    # Send the Wake-on-LAN packet
    wakeonlan -i $BROADCAST_ADDRESS $MAC_ADDRESS
}

nb_new() {
  # Base name for the notebook
  local base_name="untitled"
  # Start with the suffix 00
  local suffix="00"
  local extension=".ipynb"

  # Check if a filename argument is provided
  if [ -n "$1" ]; then
    notebook_name="$1$extension"
  else
    notebook_name="${base_name}_${suffix}${extension}"
    
    # Increment the suffix until we find a name that doesn't exist
    while [ -f "$notebook_name" ]; do
      # Convert the suffix to an integer, increment it, and pad with leading zeros
      suffix=$(printf "%02d" $((10#$suffix + 1)))
      notebook_name="${base_name}_${suffix}${extension}"
    done
  fi

  # Minimal JSON structure for a new Jupyter Notebook
  local notebook_content='{
 "cells": [],
 "metadata": {},
 "nbformat": 4,
 "nbformat_minor": 5
}'

  # Create the notebook file with the minimal JSON structure
  echo "$notebook_content" > "$notebook_name"

  # Start Jupyter Notebook with the new notebook
  jupyter notebook "$notebook_name"
}

print_random_vim_command() {
    local commands
    commands=(
        "gg: Move to the first line of the file"
        "G: Move to the last line"
        "gg=G: Reindent the whole file"
        "gv: Reselect the last visual selection"
        "\`<: Jump to beginning of last visual selection"
        "\`>: Jump to end of last visual selection"
        "^: Move to first non-blank character of the line"
        "g_: Move to the last non-blank character of the line"
        "g_lD: Delete all the trailing whitespace on the line"
        "ea: Append to the end of the current word"
        "gf: Jump to the file name under the cursor"
        "xp: Swap character forward"
        "Xp: Swap character backward"
        "yyp: Duplicate the current line"
        "yapP: Duplicate the current paragraph"
        "dat: Delete around an HTML tag, including the tag"
        "dit: Delete inside an HTML tag, excluding the tag"
        "w: Move one word to the right"
        "b: Move one word to the left"
        "dd: Delete the current line"
        "zc: Close current fold"
        "zo: Open current fold"
        "za: Toggle current fold"
        "zi: Toggle folding entirely"
        "<<: Outdent current line"
        ">>: Indent current line"
        "z=: Show spelling corrections"
        "zg: Add to spelling dictionary"
        "zw: Remove from spelling dictionary"
        "~: Toggle case of current character"
        "gUw: Uppercase word"
        "gUiw: Uppercase inside word"
        "gUU: Uppercase entire line"
        "gu$: Lowercase until the end of the line"
        "da\\\": Delete the next double-quoted string"
        "+: Move to the first non-whitespace character of the next line"
        "S: Delete current line and go into insert mode"
        "I: Insert at the beginning of the line"
        "ci\\\": Change what’s inside the next double-quoted string"
        "ca\\{: Change inside braces"
        "vaw: Visually select word"
        "dap: Delete the whole paragraph"
        "r: Replace a character"
        "\`\\[: Jump to beginning of last yanked text"
        "\`\\]: Jump to end of last yanked text"
        "g;: Jump to the last change you made"
        "g,: Jump back forward through the change list"
        "&: Repeat last substitution on current line"
        "g&: Repeat last substitution on all lines"
        "ZZ: Save the current file and close it"
        "0: Move to the beginning of the line"
        "\$: Move to the end of the line"
        "W: Move forward to the next word (whitespace delimited)"
        "E: Move forward to the end of the word (whitespace delimited)"
        "B: Move backward to the previous word (whitespace delimited)"
        "f<char>: Move forward to the next occurrence of <char>"
        "F<char>: Move backward to the previous occurrence of <char>"
        "t<char>: Move forward to just before the next occurrence of <char>"
        "T<char>: Move backward to just before the previous occurrence of <char>"
        ";: Repeat the last f, F, t, or T command"
        ",: Repeat the last f, F, t, or T command in the opposite direction"
        "H: Move to the top of the screen"
        "M: Move to the middle of the screen"
        "L: Move to the bottom of the screen"
        "%: Move to the matching parenthesis, bracket, or brace"
        "/{pattern}: Search forward for {pattern}"
        "?{pattern}: Search backward for {pattern}"
        "n: Repeat the last search forward"
        "N: Repeat the last search backward"
        "*: Search forward for the word under the cursor"
        "#: Search backward for the word under the cursor"
        "gE: Move backward to the end of the previous word"
        "ge: Move backward to the end of the previous word"
    )
    RANDOM_INDEX=$((1 + RANDOM % ${#commands[@]}))
    echo "Vim command of the day: ${commands[RANDOM_INDEX]}"
}

print_random_vim_command

export PYTHONDONTWRITEBYTECODE=1

list_dir_sizes() {
    local dir="${1:-.}" # Default to the current directory if no argument is provided

    if [[ ! -d "$dir" ]]; then
        echo "Error: '$dir' is not a valid directory."
        return 1
    fi

    echo "Directories and their sizes in human-readable format in '$dir', sorted by size:"
    du -sh -- "$dir"/* 2>/dev/null | grep '^ *[0-9]' | sort -hr
}

remove_node_modules() {
    local dir="${1:-.}" # Default to the current directory if no argument is provided

    if [[ ! -d "$dir" ]]; then
        echo "Error: '$dir' is not a valid directory."
        return 1
    fi

    echo "Searching for 'node_modules' directories in '$dir'..."
    find "$dir" -type d -name "node_modules" -prune | while read -r node_modules_dir; do
        echo "Deleting: $node_modules_dir"
        rm -rf "$node_modules_dir"
    done

    echo "All 'node_modules' directories have been removed."
}


alias lds="list_dir_sizes"