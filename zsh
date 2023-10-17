# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi

  # Custom (Random emoji) 
  emojis=("⚡️" "🔥" "🇰" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🚦" "🌙")
  #RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1)) 
  prompt_segment black default "${emojis[10]} "
}


source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#------------------------------------------------------------------------#
# Custom Funciton
#------------------------------------------------------------------------#
# Kill All Tcp
killtcp () { kill -9 $(lsof -sTCP:LISTEN -i:$1 -t) }
# Open the VSCode
#code () { VSCODE_CWD="$PWD" open -n -b "Visual Studio Code - Insiders.app" --args $* ;}
alias code='code-insiders'


# Configuration for Remote Server
source ~/.ssh/config.shlib;

# myssh codenavi
myssh () {
  key=$(tr '[a-z]' '[A-Z]' <<< $1)
  ssh -i $(config_get $key"_KEY") $(config_get $key"_HOST") -p $(config_get $key"_PORT");
  # ssh $(config_get $key"_HOST") -p $(config_get $key"_PORT");
}
# myscp codenavi ~/Download/test.txt /var/www/ghost/cote
myscp () {
  key=$(tr '[a-z]' '[A-Z]' <<< $1)
  scp  -P$(config_get $key"_PORT") ${2} $(config_get $key"_HOST"):${3};
}

idea () {
  open -na "IntelliJ IDEA.app" --args "$@"
} 

#------------------------------------------------------------------------#
# OPENSSL
#------------------------------------------------------------------------#
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

#------------------------------------------------------------------------#
# Manage Multiple Java Versions
# https://chamikakasun.medium.com/how-to-manage-multiple-java-version-in-macos-e5421345f6d0
#------------------------------------------------------------------------#
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

jdk() {
  version=$1
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}


#------------------------------------------------------------------------#
# brew install inetutils
#------------------------------------------------------------------------#
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
export PATH="/opt/homebrew/opt/inetutils/libexec/gnubin:$PATH"

#------------------------------------------------------------------------#
# Android
#------------------------------------------------------------------------#
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#------------------------------------------------------------------------#
# .NET SDK 
#------------------------------------------------------------------------#
export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono/
export PATH=$PATH:/usr/local/share/dotnet/
export PATH=$PATH:/opt/homebrew/bin/

#------------------------------------------------------------------------#
# Python
#------------------------------------------------------------------------#
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
eval "$(pyenv virtualenv-init --path)"

export PATH="/opt/homebrew/anaconda3/bin:$PATH"


#------------------------------------------------------------------------#
# Sublime : https://www.sublimetext.com/docs/command_line.html
#------------------------------------------------------------------------#
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

#alias subl="subl -na --safe-mode"


#------------------------------------------------------------------------#
# 파이참 에디터 After 2021
#------------------------------------------------------------------------#
# alias pycharm="open -b /Applications/PyCharm*CE.app/Contents/MacOS/pycharm"
alias charm="open -na 'PyCharm.app'"


#------------------------------------------------------------------------#
# 파이참 에디터 After 2021
#------------------------------------------------------------------------#
host_key_snow() {
  ssh -i ~/.ssh/snowpipe_cglee_rsa -o StrictHostKeyChecking=no  ssh://git@main.sp.snowpipe.net:222
}

server-test() {
  cd /Users/cglee/Dev/snow/Project/ProjectSP-Test/ProjectSP-Server
  host_key_snow
}

server() {
  cd /Users/cglee/Dev/snow/Project/ProjectSP-Server
  host_key_snow
}

client() {
  cd /Users/cglee/Dev/snow/Project/ProjectSP-ClientMac
}


designer() {
  cd /Users/cglee/Dev/snow/Project/data-for-designer
  host_key_snow
}

client-data() {
  cd /Users/cglee/Dev/snow/Project/ProjectSP-Data
}

schema() {
  cd /Users/cglee/Dev/snow/Project/ProjectSP-SSDT
  host_key_snow
}

datatool() {
  cd /Users/cglee/Dev/snow/Project/fastapi-nano
  host_key_snow
}

study() {
  cd /Users/cglee/Dev/BackEnd/Java/Spring/spring-meeting
}

blog() {
  cd /Users/cglee/Dev/MyBlog/ghost-blog
}

cote() {
  cd /Users/cglee/Dev/Cote
}

basic() {
  cd /Users/cglee/Dev/Cote/cote_basic
}

guni() {
  cd /Users/cglee/Dev/snow/Project/fastapi-nano
  gunicorn app.main:app --timeout 600 --workers 4  --worker-class uvicorn.workers.UvicornWorker -b 0.0.0.0:8080 --preload
}


msa() {
  cd /Users/cglee/Dev/BackEnd/Spring/spring-msa
}

export DEV="/Users/cglee/Dev"

#------------------------------------------------------------------------#
# Kafka
#------------------------------------------------------------------------#
export KAFKA="$DEV/DevOps/msa/kafka_2.13-3.4.0"
export PATH="$KAFKA/bin:$PATH"
export KAFKA_CONNECT="$DEV/DevOps/msa/confluent-7.4.0"
export PATH="$KAFKA_CONNECT/bin:$PATH"

#------------------------------------------------------------------------#
# Random Password Generator
#------------------------------------------------------------------------#
genpasswd() {
  openssl rand -base64 14
}

#------------------------------------------------------------------------#
# Random Password Generator
#------------------------------------------------------------------------#
lol() {
  cd '/Applications/League of Legends.app/Contents/LoL/'
  ./LeagueClient.app/Contents/MacOS/LeagueClient
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#------------------------------------------------------------------------#
# Homebrew
#------------------------------------------------------------------------#
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
    export HOMEBREW_PREFIX="/usr/local";
    export HOMEBREW_CELLAR="/usr/local/Cellar";
    export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
    export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}";
    export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/usr/local/share/info:${INFOPATH:-}";
fi


