#!/bin/bash
BLOGDIR=pages/lipu

POSTS=$(find ${BLOGDIR}/*.md)

RETURNDATE=""

function getdate {
	FILEDATE=$(sed -n 4p "$1")
	FILEDATE=${FILEDATE#"date: "}
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

	TITLE=$(sed -n 2p "$f" | sed "s/'//g")
	TITLE=${TITLE#"title: "}

	OUTPAGE=${f%.md}.html
	OUTPAGE=${OUTPAGE#"${BLOGDIR}/"}

	echo -e "::: blogentry\n"
	echo -e "[[$TITLE]($OUTPAGE)]{.bloglink} ($(date -d "@$MTIME" "+%Y-%m-%d"))\n"

	PREAMBLE=$(sed '/^<!-- cut -->$/Q' "$f")
	if [[ $(echo "$PREAMBLE" | wc -l) -lt 8 ]]; then
		CLEANED=$(echo "$PREAMBLE" | sed 's/%.*//g ; /^$/d')
		echo -e "\n[$CLEANED]{.blogdetails}\n"
	fi
	echo -e "\n:::\n"
done

rm blogdates.txt
