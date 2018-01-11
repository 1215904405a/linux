export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

#color{{{
autoload colors #启用彩色提示符
colors

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
FINISH="%{$terminfo[sgr0]%}"
#}}}

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then printf " [%s]" $branch; fi
}

#命令行提示（路径和已经输入路径显示） prompt -l 参考：http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#autoload -U promptinit
#promptinit
#prompt bart
#右边输出时间
RPROMPT=$(echo "$RED%T$FINISH")
#左边输出
#%{$fg[cyan]%}%c 当前文件目录
if [ "$(git_prompt_info)" ]; then
  ZSH_PROMPT="${ret_status} %{$reset_color%}$(git_prompt_info)"
else
  ZSH_PROMPT=""
fi
#echo "$ZSH_PROMPT"
#$YELLOW%M 主机名
PROMPT='$CYAN%n@$GREEN%/ ${ret_status} %{$reset_color%}$(git_prompt_info)'

#标题栏、任务栏样式{{{
#echo $TERM
case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
precmd () { print -Pn "\e]0;%n@%M %/\a" }
preexec () { print -Pn "\e]0;%n@%M %/\ $1\a" }
;;
'wt')
print -Pn "3333333"
;;
esac
#}}}

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE
#}}}


#设置别名
alias gs='git status'
alias grp='git remote prune origin'
alias gsr='git submodule update --init --recursive'
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1'
#历史命令
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
#别名补全
setopt completealiases
#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
hash -d qd="/Users/wangyong/Documents/qd/"
#}}}

##在命令前插入 sudo
sudo-command-line() {
    #eval echo $BUFFER

    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line


#键盘快捷键绑定
#ncmpcppShow() { BUFFER="sudo nodemon server.js"; zle accept-line; }
#zle -N ncmpcppShow
#bindkey 'q' ncmpcppShow

#第一个使用 Alt+Left 让用户撤销最近的 cd 操作，第二个使用 Alt+Up 让用户进入上层目录
cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
  pushd    > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[^[[D'      cdParentKey
bindkey '^[^[[A'      cdUndoKey

#自动补全
autoload -U compinit
compinit

#启动使用方向键控制的自动补全
zstyle ':completion:*' menu select

