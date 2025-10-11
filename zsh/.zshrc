#>>> Alias configuration for GCC and G++
alias gcc="gcc-14"
alias g++="g++-14"

#>>> stow related aliases
alias unstow='stow --delete'

#>>> Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

#>>> setopt config
unsetopt nomatch
setopt autocd
setopt sharehistory
setopt incappendhistory
setopt interactivecomments

#>>> Enable plugins.
#plugins=(git brew history kubectl zsh-history-substring-search)
# plugins=(git brew history kubectl)

#>>> tell homebrew to not update automatically every time i run it(just once a week)
export HOMEBREW_AUTO_UPDATE_SECS=604800

#>>> Completions.
autoload -Uz compinit && compinit

#>>> Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

#>>> flush dns
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder && echo "✅ DNS cache flushed"'

#>>> zoxide(brew formulae) config
eval "$(zoxide init zsh)"

#>>> VSCode shell configuration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

#>>> audio devices
alias macbook='SwitchAudioSource -s "MacBook Air Speakers"'
alias headphones='SwitchAudioSource -s "External Headphones"'

#>>> most as the default pager for man
#export MANPAGER="most"

#>>> mysql and mysqladmin
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias xampp_stop='sudo /Applications/XAMPP/xamppfiles/xampp stopmysql'
alias xampp_start='sudo /Applications/XAMPP/xamppfiles/xampp startmysql'
alias xampp_restart='sudo /Applications/XAMPP/xamppfiles/xampp restartmysql'
alias mysql_start='sudo /usr/local/mysql/support-files/mysql.server start'
alias mysql_stop='sudo /usr/local/mysql/support-files/mysql.server stop'
alias mysql_restart='sudo /usr/local/mysql/support-files/mysql.server restart'

#>>> OpenAI API Key (REMOVED for security)
# export OPENAI_API_KEY="your_api_key_here"
# You can safely set it locally in ~/.zshrc.private or via environment variable instead.

#>>> Shortcut to eject Meetrix SSD
ejectMeetrix() {
    shortcuts run unmountMeetrix
}

#>>> Function to compile, run, and clean up C programs
runC() {
    gcc-14 "$1" -o /temp/a.out && /temp/a.out
}

#>>> Function to compile, run, and clean up Java programs
runJava() {
    local file="$1"
    local basename=$(basename "${file%.*}")
    local package=$(grep -m1 "^package " "$file" 2>/dev/null | sed 's/package //; s/;//')

    if [[ -n "$package" ]]; then
        javac "$file" && java "${package}.${basename}"
    else
        javac "$file" && java "$basename"
    fi
}

#>>> Alias to run JavaFX programs
alias javafx_run="java --module-path $JAVAFX_PATH --add-modules javafx.controls,javafx.fxml -cp ."

#>>> GitHub Copilot aliases for Zsh
eval "$(gh copilot alias -- zsh)"

#>>> fzf setup for fast file navigation
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find ~+ -type f"
bindkey '^F' fzf-file-widget

fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

fzf_rg() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

#>>> Auto-suggestions plugin for terminal (Uncomment if needed)
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#>>> direnv for automatic environment variable management (Uncomment if needed)
# eval "$(direnv hook zsh)"

#>>> Custom extract function (optional)
# extract() { ... }

#>>> SDKMAN setup
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
