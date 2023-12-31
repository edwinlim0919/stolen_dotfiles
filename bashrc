# ~/.bashrc

# Personal environment variables and startup programs
# should go into ~/.bash_profile.
# Personal aliases and functions should go into ~/.bashrc


# interactive prompt
PS1="> "

# use the following instead, if you don't want your username in the prompt
#PS1="[\h:\w]\\$ "

# continuation interactive prompt (for multi-line commands)
PS2='> '

PROMPT_COMMAND=__prompt_command    # Function to generate PS1 after CMDs

__prompt_command() {
  local EXIT="$?"                # This needs to be first
  PS1=""

  local RCol='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local BYel='\[\e[1;33m\]'
  local BBlu='\[\e[1;34m\]'
  local Pur='\[\e[0;35m\]'

  if [ $EXIT != 0 ]; then
    PS1+="${Red}\w ${Pur}> ${RCol}"        # Add red if exit code non 0
  else
    PS1+="${Gre}\w ${Pur}> ${RCol}"
  fi
}

export LS_OPTIONS='--color=auto -lh'
eval "$(dircolors -b)"
############################################################################

alias ls='ls $LS_OPTIONS'
alias l="ls -al"
alias ll="ls -al"
alias gd="cd /scratch/fpga-demo"

shopt -s histappend
export HISTSIZE=100000

# PATH="/scratch/joonho.whangbo/bin:$PATH"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# export MAKEFLAGS='-j72'
# PATH="/scratch/joonho.whangbo/coding/circt/build/bin:$PATH"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

############################################################################

# export VERILATOR_ROOT="/scratch/joonho.whangbo/coding/verilator"
# PATH="$VERILATOR_ROOT/bin:$PATH"
# export ENABLE_SBT_THIN_CLIENT=1
# export MARSHAL_BOARD_DIR="/scratch/joonho.whangbo/coding/accel_integration_chipyard/software/firemarshal/boards/chipyard"
# export RISCV="/scratch/joonho.whangbo/coding/riscv-gnu-toolchain"

# source /ecad/tools/vlsi.bashrc

############################################################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/scratch/conda-install/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/scratch/conda-install/etc/profile.d/conda.sh" ]; then
        . "/scratch/conda-install/etc/profile.d/conda.sh"
    else
        export PATH="/scratch/conda-install/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

function connect_ssh_agent() {
  # set SSH_AUTH_SOCK env var to a fixed value
  export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock

  # test whether $SSH_AUTH_SOCK is valid
  ssh-add -l 2>/dev/null >/dev/null

  # if not valid, then start ssh-agent using $SSH_AUTH_SOCK
  [ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
}



# export PATH="/tools/Xilinx/Vivado_Lab/2022.2/bin:$PATH"

source /tools/Xilinx/Vivado_Lab/2023.1/settings64.sh
