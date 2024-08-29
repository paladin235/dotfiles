if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
end

# git abbreviations
abbr -a -- ga 'git add'
abbr -a -- gaa 'git add --all'
abbr -a -- gb 'git branch -vv'
abbr -a -- gbD 'git branch --delete --force'
abbr -a -- gc 'git commit --verbose'
abbr -a -- gca 'git commit --verbose --all'
abbr -a -- gcam 'git commit --verbose --all -m'
abbr -a -- gcan! 'git commit --verbose --all --no-edit --amend'
abbr -a -- gcm 'git checkout (git_main_branch)'
abbr -a -- gco 'git checkout'
abbr -a -- gd 'git diff'
abbr -a -- gla 'git pull --all --prune --tags'
abbr -a -- glg 'git log --stat'
abbr -a -- glod 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
abbr -a -- gp 'git push'
abbr -a -- grb 'git rebase'
abbr -a -- grbm 'git rebase (git_main_branch)'
abbr -a -- gsh 'git show'
abbr -a -- gst 'git status'
abbr -a -- gsta 'git stash apply'
abbr -a -- gstp 'git stash pop'
