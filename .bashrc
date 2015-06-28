#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set environment variables
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/most
if [ -n "$DISPLAY" ]; then
    export BROWSER=/usr/bin/firefox
else
    export BROWSER=/usr/bin/w3m
fi

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth

# History lenght
export HISTSIZE=1000
export HISTFILESIZE=2000

# Add to history instead of overriding it
shopt -s histappend

# Window size sanity check
shopt -s checkwinsize

# Source the Git promt script
source /usr/share/git/completion/git-prompt.sh

# Set options for Git prompt
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_SHOWSTASHSTATE=yes
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=yes

# Font attributes
export reset="$(tput sgr0)" bold="$(tput bold)" dim="$(tput dim)" blink="$(tput blink)" \
    underline="$(tput smul)" end_underline="$(tput rmul)" reverse="$(tput rev)" \
    hidden="$(tput invis)"

# Font colors
export black="$(tput setaf 0)" red="$(tput setaf 1)" green="$(tput setaf 2)" \
    yellow="$(tput setaf 3)" blue="$(tput setaf 4)" magenta="$(tput setaf 5)" \
    cyan="$(tput setaf 6)" white="$(tput setaf 7)" default="$(tput setaf 9)"

# Font background colors
export bg_black="$(tput setab 0)" bg_red="$(tput setab 1)" bg_green="$(tput setab 2)" \
    bg_yellow="$(tput setab 3)" bg_blue="$(tput setab 4)" bg_magenta="$(tput setab 5)" \
    bg_cyan="$(tput setab 6)" bg_white="$(tput setab 7)" bg_default="$(tput setab 9)"

_PROMPT() {
    local EXIT_STATUS="$?"

    # Other variables
    local _time12h="\T" _time12a="\@" _time24h="\t" _time24s="\A" _cwd_short="\W" \
          _cwd_full="\w" _new_line="\n" _jobcount="\j"

    # Set variables for PS1 string
    local _br1="\[${bold}${black}\][\[${reset}\]" _br2="\[${bold}${black}\]]\[${reset}\]" \
          _div1="\[${bold}${black}\] » \[${reset}\]" _div2="\[${bold}${black}\]╺─╸\[${reset}\]" \
          _line1="\[${red}\]┌─╼\[${reset}\]" _line2="\[${red}\]└────╼\[${reset}\]" \
          _sep="\[${reset}\]@" _title_sep="@" 
    local _cwd="${_br1}${_cwd_short}${_br2}" _title_cwd="[${_cwd_short}]" \
          _time="${_br1}${_time24h}${_br2}" 

    # Exit status string
    [ $EXIT_STATUS != 0 ] && local _errmsg="${_br1}\[${bold}${red}\]${EXIT_STATUS}${_br2}"

    # User
    if (( UID == 0 )); then
        local _user="\[${red}\]root\[${reset}\]" _title_user="root"
    else
        local _user="\[${green}\]\u\[${reset}\]" _title_user="\u"
    fi

    # Hostname
    if [[ $SSH_TTY ]]; then
        local _host="\[${blue}\]\h" _title_ssh="ssh://" _title_host="\h"
    else
        local _host="\[${yellow}\]\h" _title_ssh="" _title_host="\h"
    fi
    
    # Jobs
    if [[ $(echo -n `jobs | egrep -c \[[:digit:]+\]`) != 0 ]]; then
        local _jobs="${_br1}\[${bold}${green}\]${_jobcount}${_br2}"
    else
        local _jobs=""
    fi

    # Get the Git shell 
    local _git_branch="$(__git_ps1 "%s")"

    if [[ ${_git_branch} != "" ]] && [[ ${PWD} =~ "/.git" ]]; then
        # CWD is inside a .git directory
        local _git="${_br1}\[${red}\]${_git_branch}${_br2}" _title_git="[${_git_branch}]"
    elif [[ ${_git_branch} != "" ]]; then
        local _title_git="[${_git_branch}]" 
        if [[ -z $(git status -s) ]] && ( [[ ${_git_branch} == "master" ]] || [[ ${_git_branch} == "master=" ]] ); then
            # CWD is inside an unmodified master branch
            local _git="${_br1}\[${green}\]${_git_branch}${_br2}" 
        elif [[ -z $(git status -s) ]]; then
            # CWD is inside an unmodified branch
            local _git="${_br1}\[${yellow}\]${_git_branch}${_br2}" 
        else
            # CWD is inside a modified branch
            local _git="${_br1}\[${red}\]${_git_branch}${_br2}"
        fi
    else
        # Not inside a Git branch
        local _git="" _title_git="" 
    fi

    # Set title in xterm/rxvt
    case $TERM in
        xterm*|rxvt*)
            local _title="\[\e]2;${_title_ssh}${_title_user}${_title_sep}${_title_host} ${_title_cwd} ${_title_git}\007\]" ;;
        *)
            local _title="" ;;
    esac
    
    # Set PS1
    PS1="${_title}${_line1} ${_time}${_div1}${_user}${_sep}${_host} ${_div2} ${_errmsg}${_jobs}${_cwd}${_git}${_new_line}${_line2} "
    export PS2='continue >'
    export PS4='+$BASH_SOURCE[$LINENO]: '
}

# Prompt
PROMPT_COMMAND=_PROMPT

# Aliases and shortcuts
if [ -x /usr/bin/dircolors ]; then
    # Color support
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias la='ls -a --color=auto --group-directories-first'
    alias ll='ls -l --color=auto --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto -in'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
else
    alias ls='ls --group-directories-first'
    alias la='ls -a --group-directories-first'
    alias ll='ls -l --group-directories-first'
    alias grep='grep -in'
fi

alias install='sudo pacman -S'
alias update='sudo pacman -Syu'
alias install-aur='yaourt -S'
alias update-aur='yaourt -Syua'
alias start='sudo systemctl start '
alias restart='sudo systemctl restart '
alias stop='sudo systemctl stop '
alias status='systemctl status '
alias ff='exec firefox && exit 0'
alias excuse='fortune bofh-excuses'

# Color man pages
man() {
    env \
    LESS_TERMCAP_mb=$(printf "${bold}${red}") \
    LESS_TERMCAP_md=$(printf "${bold}${red}") \
    LESS_TERMCAP_me=$(printf "${reset}") \
    LESS_TERMCAP_se=$(printf "${reset}") \
    LESS_TERMCAP_so=$(printf "${bold}${bg_blue}${yellow}") \
    LESS_TERMCAP_ue=$(printf "${reset}") \
    LESS_TERMCAP_us=$(printf "${bold}${green}") \
    man "$@"
}

## COMPRESSION FUNCTION ##
compress() {
    FILE=$1
    shift
    case $FILE in
        *.tar.bz2) tar cjf $FILE $*  ;;
        *.tar.gz)  tar czf $FILE $*  ;;
        *.tgz)     tar czf $FILE $*  ;;
        *.zip)     zip $FILE $*      ;;
        *.rar)     rar $FILE $*      ;;
        *)         echo "Filetype not recognized" ;;
   esac
}

## EXTRACT FUNCTION ##
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## DICTIONARY FUNCTIONS ##
dwordnet () { curl dict://dict.org/d:${1}:wn; }
dacron () { curl dict://dict.org/d:${1}:vera; }
djargon () { curl dict://dict.org/d:${1}:jargon; }
dfoldoc () { curl dict://dict.org/d:${1}:foldoc; }
dthesaurus () { curl dict://dict.org/d:${1}:moby-thes; }
dtranslate () {
    PS3="${blue}Select the dictionary: ${reset}"
    local _options="deu-eng eng-deu deu-fra fra-deu deu-ita ita-deu deu-nld nld-deu deu-por por-deu tur-deu lat-deu jpn-deu afr-deu gla-deu exit"

    select i in $_options; do
        if [ $i == "exit" ]; then
            return
        else
            printf "${blue}Enter the word to translate: ${reset}"
            read w
            curl dict://dict.org/d:${w}:fd-${i}
        fi
    done
}
