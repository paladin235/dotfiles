function gradle
  if test -f ./gradlew
    echo "Using gradle wrapper"
    ./gradlew $argv
  else
    command gradle $argv
  end
end
