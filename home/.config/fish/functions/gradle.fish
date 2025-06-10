function gradle
    set dir (pwd)
    while test "$dir" != "/"
        if test -f "$dir/gradlew"
            echo "Using gradle wrapper at $dir/gradlew"
            "$dir/gradlew" $argv
            return
        end
        set dir (dirname "$dir")
    end
    echo "No gradlew found in parent directories, using system gradle"
    command gradle $argv
end
