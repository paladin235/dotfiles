function git_main_branch
  if git show-ref -q --verify refs/heads/main 2>/dev/null
    echo -n main
  else if git show-ref -q --verify refs/heads/master 2>/dev/null
    echo -n master
  end
end
