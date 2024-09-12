########################################################################################
# Alias definitions
alias python=python3
alias pip=pip3
alias c='clear'
alias l='ls -al'
alias ls='ls -GFh'
alias jcov="find . -name jacoco -type d -exec open '{}/index.html' \;"
# javadoc generates error sometimes. replacing && with ; for now
alias jdoc="rm -rf javadocs && javadoc -d javadocs **/src/**/*.java; open javadocs/index.html"
alias rs-start="docker run -d --cap-add sys_resource --name rp -p 8443:8443 -p 9443:9443 -p 12000:12000 redislabs/redis"

# Emacs to use cocoa emacs app
# alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs

alias e='ec'
alias ep='emacsplus'

# alias emacsclient to 'ecl'
alias enw='emacsclient -nw'

alias m='make'
alias g='git'
alias t="tree -I 'node_modules|cache'"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,node_modules,cache}"
alias pass='openssl rand -base64 16'
alias rvmg='rvm gemset use'
alias tssh='tsh ssh'

# alias scheme="rlwrap -r -c -f ~/extn.d/mit_scheme_bindings.txt scheme"
alias ghci="ghci -XNPlusKPatterns"
alias hivec="hive -hiveconf hive.root.logger=DEBUG,console"
# alias jnote="jupyter notebook --notebook-dir=~/repo/notebooks"

alias docker=podman

function show() {
    echo "rvm: "`rvm-prompt`
    echo "git branch: "`git_current_branch`
    git-config.sh
}

function cleandir() {
    rm -rf $1 && mkdir -p $1 && cd $1
}

# source: https://stackoverflow.com/questions/8590872/pipe-emacs-shell-output-to-a-new-buffer
# in future, check this, https://www.emacswiki.org/emacs/EmacsClient#toc17, as well
function open_in_emacs_buffer() {
    # Open the stdin in a separate emacs buffer
    # Create a temporary file and copy the contents
    # Open the file in emacsclient
    perl -MFile::Temp -MFile::Copy -e \
         'copy *STDIN, $file = File::Temp->new; system "emacsclient", $file';
}

alias shw='show'
alias eb='open_in_emacs_buffer'
# open jacoco code coverage report
alias jccr='open build/reports/jacoco/html/index.html'
# alias to git root
alias root='cd $(git root)'
alias main='git co $(git main)'
alias jutr="find . -name reports -type d -exec open '{}/tests/test/index.html' \;"

alias epipe="emacspipe"
alias kc=kubectl
