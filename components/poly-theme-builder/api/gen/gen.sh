#!/bin/sh
FILE=$1
SEPARATOR=$2
ELEMENT=`echo $FILE | sed 's/\.data//g'`
IFS=$'\n'

echo "  {"
echo "    \"element\": \"$ELEMENT\","

echo "    \"properties\": ["

START=""
for i in `grep '^\`' $FILE | sed 's/\`//g'`
do
  PROP=`echo $i | sed 's/ .*//g'`
  DESC=`echo $i | sed 's/.*|[\t\s ]*\(.*\) |.*/\1/g' | sed 's/[ \s\t]*$//g'`
  VAL=`echo $i | sed 's/.*\s//g'`

  echo "$START"
  echo "      {"
  echo "        \"name\": \"$PROP\","
  echo "        \"description\": \"$DESC\","

  if [ "{}" = "$VAL" ]
  then
    echo "        \"mixin\": true,"
    echo "        \"type\": \"Object\","
    echo "        \"default\": $VAL"
  else
    echo "        \"type\": \"Color\","
    echo "        \"default\": \"$VAL\""
  fi
  START="      },"

done
  echo "      }"

echo "    ]"

echo "  }$SEPARATOR"
