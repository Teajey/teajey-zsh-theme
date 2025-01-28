# Teajey's oh-my-zsh theme!

# Perl function adapted from the fishy theme. Collapses the path to the "most relevant" directories:
# e.g.   ~/Documents/dir1/dir2/dir3/dir4/dir5   becomes  ~/Documents/.../dir4/dir5
#        /etc/dir1/dir2/dir3/dir4/dir5          becomes  /etc/.../dir4/dir5
# Edit the numbers in the curly braces in the regex below to change the amount of directories shown on either side of the collapsed path.
_accordion_path() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s/(^(?:[^\/]*\/){2})(.+)(?=(?:\/[^\/]+){2}\/*$)/$1.../g;
')
}

precmd () { 
   psvar[1]=$(_accordion_path);
   psvar[2]=$(git_prompt_info);
}

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"
local open_sq_bckt="%{$fg_bold[red]%}[%{$reset_color%}"
local close_sq_bckt="%{$fg_bold[red]%}]%{$reset_color%}"
local user="%{$fg_bold[yellow]%}%n%{$reset_color%}"
local at="%{$fg_bold[green]%}@%{$reset_color%}"
local host="%{$fg_bold[blue]%}%m%{$reset_color%}"
local dir="%{$fg_bold[magenta]%}%1v%{$reset_color%}"
local git_branch="%{$fg_bold[cyan]%}%2v%{$reset_color%}"
local newline="\n%{$fg_bold[green]%}\$%{$reset_color%} "

# Command line adapted from the murilasso theme:
# [username@hostname path] gitbranch                                 errcode #
# $ 
PROMPT="${open_sq_bckt}${user}${at}${host} ${dir}${close_sq_bckt} ${git_branch}%B%b${newline}"
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
