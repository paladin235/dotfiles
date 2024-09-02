function gradle
  if test -f ./gradlew
    echo "Using gradle wrapper"
    ./gradlew $argv
  else
    gradle $argv
  end
end
