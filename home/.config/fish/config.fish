if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
end

# system abbreviations
abbr df df -h
abbr k kubectl
abbr tree tree --dirsfirst

# git abbreviations
abbr ga git add
abbr gaa git add --all
abbr gb git branch -vv
# delete local branches where the tracking branch is gone
abbr gbdg 'git branch --delete --force $(git branch -vv | grep ": gone]" | choose 0)'
abbr gbD git branch --delete --force
abbr gc git commit --verbose
abbr gca git commit --verbose --all
abbr gca! git commit --verbose --all --amend
abbr gcam --set-cursor git commit --verbose --all -m 
abbr gcan! git commit --verbose --all --no-edit --amend
abbr gcb git checkout -b
abbr gcm 'git checkout (git_main_branch)'
abbr gco git checkout
abbr gd git diff
abbr gla git pull --all --prune --tags
abbr gl git log
abbr gls git log --stat
abbr glg git log --graph --pretty=single
abbr gp git push
abbr gpf git push --force
abbr grb git rebase
abbr grba git rebase --abort
abbr grbc git rebase --continue
abbr grbm 'git rebase (git_main_branch)'
abbr grh git reset 
abbr grhh git reset --hard
abbr gsh git show
abbr gst git status
abbr gsta git stash
abbr gstd git stash drop
abbr gstl git stash list
abbr gsts git stash show
abbr gstaa git stash apply
abbr gstam --set-cursor git stash -m 
abbr gstp git stash pop

# Directory traversal abbreviations
abbr -a -- '...' 'cd ../..'
abbr -a -- '....' 'cd ../../..'
abbr -a -- '.....' 'cd ../../../..'


fish_add_path -g ~/.local/bin

# OS specific config
switch (uname)
    case Darwin
        abbr -a -- readlink greadlink
        abbr -a -- find gfind
        abbr -a -- idea 'open -na "/Users/daniel/Applications/IntelliJ IDEA Ultimate.app" --args'

        fish_add_path -g /Users/daniel/git/phdata/toolkit/toolkit-cli/build/install/toolkit-cli
        fish_add_path -g /opt/homebrew/bin
        fish_add_path -g /opt/homebrew/opt/node@22/bin
        set -gx JAVA_HOME (/usr/libexec/java_home -v 24)
        set -gx SNOWFLAKE_PRIVATE_KEY_FILE "$HOME/.ssh/toolkit/snowboarder-it.p8"
    case Linux
        set -gx MAN_POSIXLY_CORRECT 1
        fish_add_path -g /opt/bin
end

# add direnv hook if direnv is installed
if type -q direnv
    direnv hook fish | source
end

# Added by Windsurf
fish_add_path /Users/daniel/.codeium/windsurf/bin
