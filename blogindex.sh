#!/bin/bash
BLOGDIR=pages/lipu

POSTS=$(find ${BLOGDIR}/*.md)

RETURNDATE=""

# date is read from the 3rd %ed line
function getdate {
	FILEDATE=$(grep "^%" "$1" | sed '3q;d' | cut -d ' ' -f 2-)
	RETURNDATE=$(date -u --date="$FILEDATE" "+%s")
}

echo -n >blogdates.txt
for f in $POSTS; do
	getdate "$f"
	printf "%d\t%s\n" "$RETURNDATE" "$f" >>blogdates.txt
done

# sort by times
POSTS=$(sort -nr <blogdates.txt | cut -f 2-)

cat templates/blog_header.md

for f in $POSTS; do
	getdate "$f"
	MTIME=$RETURNDATE

	TITLE=$(head -n 1 "$f")
	TITLE=${TITLE#"% "}

	OUTPAGE=${f%.md}.html
	OUTPAGE=${OUTPAGE#"${BLOGDIR}/"}

	echo -e "* **[$TITLE]($OUTPAGE)** ($(date -d "@$MTIME" "+%Y-%m-%d"))\n"

	PREAMBLE=$(sed '/^<!-- cut -->$/Q' "$f")
	if [[ $(echo "$PREAMBLE" | wc -l) -lt 8 ]]; then
		CLEANED=$(echo "$PREAMBLE" | sed 's/%.*//g ; /^$/d')
		echo -e "\n> $CLEANED\n"
	fi
done

rm blogdates.txt
