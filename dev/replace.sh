#!/usr/bin/env sh
FILE="./grammars/raku.cson"
TEMP_FILE="${FILE}.new"
FILE2="./grammars/raku.quoting.cson"
TEMP_FILE2="${FILE2}.new"
raku ./dev/q-qq-Q-template.raku
if [ ! -f ZERO.cson ]; then
  exit 1
fi
awk '
    BEGIN       {p=1}
    /^#0START/   {print;system("cat ZERO.cson");p=0}
    /^#0END/     {p=1}
    p' "${FILE}" > "${TEMP_FILE}"
rm ZERO.cson
mv "${TEMP_FILE}" "${FILE}"

awk '
    BEGIN       {p=1}
    /^#1START/   {print;system("cat FIRST.cson");p=0}
    /^#1END/     {p=1}
    p' "${FILE2}" > "${TEMP_FILE2}"
rm FIRST.cson
mv "${TEMP_FILE2}" "${FILE2}"

awk '
    BEGIN       {p=1}
    /^#2START/   {print;system("cat SECOND.cson");p=0}
    /^#2END/     {p=1}
    p' "${FILE2}" > "${TEMP_FILE2}"
rm SECOND.cson
mv "${TEMP_FILE2}" "${FILE2}"

awk '
    BEGIN       {p=1}
    /^#3START/   {print;system("cat THIRD.cson");p=0}
    /^#3END/     {p=1}
    p' "${FILE}" > "${TEMP_FILE}"
rm THIRD.cson
mv "${TEMP_FILE}" "${FILE}"

awk '
    BEGIN       {p=1}
    /^#REGEX_START/   {print;system("cat REGEX.cson");p=0}
    /^#REGEX_END/     {p=1}
    p' "${FILE}" > "${TEMP_FILE}"
rm REGEX.cson
mv "${TEMP_FILE}" "${FILE}"

printf "Done!\n"
