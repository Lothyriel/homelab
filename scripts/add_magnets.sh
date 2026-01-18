file="$1"

while IFS= read -r line; do
  qbt torrent add url "$line"
done < "$file"
