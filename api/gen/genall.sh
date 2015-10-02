#!/bin/sh
echo "["
for i in *.data
do
  gen.sh $i ","
done
echo "  { \"element\": \"dummy\" }" #hack around trailing comma
echo "]"
