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
echo ""

for f in $POSTS; do
	PUBLISHED=$(head -n 4 "$f" | tail -n 1)
	if [ "$PUBLISHED" != "% published: true" ]; then # lol
		continue
	fi

	getdate "$f"
	MTIME=$RETURNDATE

	TITLE=$(head -n 1 "$f")
	TITLE=${TITLE#"% "}

	OUTPAGE=${f%.md}.html
	OUTPAGE=${OUTPAGE#"${BLOGDIR}/"}

	echo -e "::: blogentry\n"
	echo -e "<a href=\"/lipu/$OUTPAGE\" class=\"bloglink\">$TITLE</a> ($(date -d "@$MTIME" "+%Y-%m-%d"))\n"
	PREAMBLE=$(sed '/^<!-- cut -->$/Q' "$f")
	if [[ $(echo "$PREAMBLE" | wc -l) -lt 8 ]]; then
		CLEANED=$(echo "$PREAMBLE" | sed 's/%.*//g ; /^$/d')
		echo -e "\n<p class=\"blogdetails\">$CLEANED</p>\n"
	fi
	echo -e "\n:::\n"
done

rm blogdates.txt
