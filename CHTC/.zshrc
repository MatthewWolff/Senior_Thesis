export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="wolffy"

plugins=(
  git battery
)

#### USER CONFIGURATION
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Valid command highlighter
source $ZSH/oh-my-zsh.sh

#### FUNCTIONS
cd(){ builtin cd $@ && ls; }
addalias()
{
  new_alias="alias $(echo $1 | sed -e "s/=/='/" -e "s/$/'/")"
  echo $new_alias >> ~/.zshrc
  source ~/.zshrc # order matters
}
settheme()
{
  sed -i '' -e "s/ZSH_THEME=\"[a-z]*\"/ZSH_THEME=\"$1\"/" ~/.zshrc
  source ~/.zshrc
}
make_job()
{
  cp ~/jobs/template.sub ~/jobs/$1.sub
  sed "s/template/$1/g" ~/jobs/$1.sub -i''
  echo $'#!/bin/bash\nexit' >> ~/scripts/$1.sh
  chmod +x ~/scripts/$1.sh
  echo "created $1.sub with 10GB of requested memory and disk space"
}
cl()
{
  directory=~/submitted/logs
  log_file=`ls -ct1 $directory | head -n1`
  log_file=$directory/$log_file
  cat $log_file && echo $log_file
}
ce()
{
  directory=~/submitted/errs
  err_file=`ls -ct1 $directory | head -n1`
  err_file=$directory/$err_file
  cat $err_file && echo $err_file
}
co()
{
  directory=~/submitted/output
  out_file=`ls -ct1 $directory | head -n1`
  out_file=$directory/$out_file
  cat $out_file && echo $out_file
}
update_thesis()
{
  # keep zshrc and notes up to date
  cp ~/.notes ~/.zshrc ~/Senior_Thesis/CHTC/
  # determine changes
  scripts=$(diff -rq ~/desman_scripts ~/Senior_Thesis/CHTC/scripts | \
              perl -nle "print $& if m{(?<=/).+\.sh(?= a)}")
  jobs=$(diff -rq ~/jobs ~/Senior_Thesis/CHTC/jobs | perl -nle "print $& if m{(?<=/).+\.sub(?= a)}")
  # copy all scripts over with their corresponding .sub. Ignores jobs differences
  cp ~/desman_scripts/* ~/Senior_Thesis/CHTC/scripts/
  for s in `\ls ~/desman_scripts`;do cp ~/jobs/`basename $s .sh`.sub ~/Senior_Thesis/CHTC/jobs/;done
  # announce changes
  if [[ ! -z $scripts ]]; then 
    echo -n "changed scripts: "
    for s in $scripts; do echo -n "$(basename $s) "; done; echo
  fi
  if [[ ! -z $jobs ]]; then
    echo -n "changed jobs: "
    for j in $jobs; do echo -n "$(basename $j) "; done; echo
  fi
}
notes(){ if [[ -z $1 ]]; then echo -n "\033[33m" && cat ~/.notes; else echo "> $*" >> ~/.notes; fi;}
echo "\033[1m\033[37mHey! Remember to take notes on what you're doing --- notes <notes> <date>"

#### ALIASES
alias daddy='sudo'
alias theme='source ~/.zshrc' # picks a random theme if curr theme is "random"
alias rand='[[ $ZSH_THEME = random ]] || settheme random; source ~/.zshrc'
alias shrink='export PS1="\u > "' # temporarily shrink prompt
alias search='grep -rwn * -e '
alias push='git push -u origin master'
alias pull='git pull'
alias gaa='git add --all'
alias 'gcn!'='git commit -v --no-edit --amend'  # retroactively commit files to last commit
alias force='git push -u -f origin master'
alias 'oops!'='gaa && gcn! && force'
alias gits='git status'
alias ls='ls --color'  # ls -G on mac
alias grep='grep --color=auto' 
alias rc='vim ~/.zshrc'
alias glust='ssh transfer.chtc.wisc.edu'
alias src='source ~/.zshrc'
alias cs='condor_submit'
alias q='condor_q'
alias crm='condor_rm'
alias mkjob='make_job'
