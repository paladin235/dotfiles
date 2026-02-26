function jwt-decode
  echo $argv[1] | jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)'
end
