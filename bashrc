#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source the Git promt script
source /usr/share/git/completion/git-prompt.sh

# Load files from ~/.bashrc.d
if [ -d ${HOME}/.bashrc.d ]; then
    for file in ${HOME}/.bashrc.d/*; do
        source "$file";
    done
fi

