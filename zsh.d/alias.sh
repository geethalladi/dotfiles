########################################################################################
# Alias definitions

alias c='clear'
alias l='ls -al'
alias ls='ls -GFh'

# Emacs to use cocoa emacs app
# alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs

alias e='ec'

# alias emacsclient to 'ecl'
alias ecl='emacsclient -nw'

alias m='mvn -Dmaven.javadoc.skip=true'
alias g='git'
alias t='tree'
alias pass='openssl rand -base64 16'
alias rg='rvm gemset use'


alias scheme="rlwrap -r -c -f ~/extn.d/mit_scheme_bindings.txt scheme"
alias ghci="ghci -XNPlusKPatterns"
alias hivec="hive -hiveconf hive.root.logger=DEBUG,console"
# alias jnote="jupyter notebook --notebook-dir=~/repo/notebooks"

function show() {
    echo "rvm: "`rvm-prompt`
    echo "git branch: "`git_current_branch`
    git-config.sh
}
alias shw='show'
