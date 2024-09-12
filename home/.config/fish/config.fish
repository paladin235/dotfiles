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
abbr gbD git branch --delete --force
abbr gc git commit --verbose
abbr gca git commit --verbose --all
abbr gcb git checkout -b
abbr gcam --set-cursor git commit --verbose --all -m \"%\"
abbr gcan! git commit --verbose --all --no-edit --amend
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
abbr gstam --set-cursor git stash -m "%"
abbr gstp git stash pop

fish_add_path -g ~/.local/bin

# OS specific config
switch (uname)
    case Darwin
        abbr -a -- readlink greadlink
        abbr -a -- find gfind
        abbr -a -- idea 'open -na "/Users/daniel/Applications/IntelliJ IDEA Ultimate.app" --args'

        fish_add_path -g /Users/daniel/git/phdata/toolkit/toolkit-cli/build/install/toolkit-cli
        fish_add_path -g /opt/homebrew/bin
        set -gx JAVA_HOME /opt/homebrew/Cellar/openjdk@21/21.0.4/libexec/openjdk.jdk/Contents/Home
    case Linux
        fish_add_path -g /opt/bin
end

# add direnv hook if direnv is installed
if type -q direnv
    direnv hook fish | source
end
