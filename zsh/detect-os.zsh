if [[ `uname` == 'Linux' ]]; then
  export OS=linux
  # Path to your oh-my-zsh installation.
  export ZSH=/home/puritanic/.oh-my-zsh

elif [[ `uname` == 'Darwin' ]]; then
  export OS=osx
  # Path to your oh-my-zsh installation.
  export ZSH=/Users/puritanic/.oh-my-zsh
fi
