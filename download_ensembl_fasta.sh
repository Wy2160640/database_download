#!/bin/bash
# -*- coding: utf-8 -*-
# author=yhwang


[ -e /tmp/tumorpipe  ] || mkfifo /tmp/tumorpipe
exec 3<>/tmp/tumorpipe
rm -rf /tmp/tumorpipe

for ((i=1;i<=6;i++))
do
        echo >&3
done

while read href
do
read -u3
{

wget -np -r -A ".dna.toplevel.fa.gz" $href

echo >&3

}&
done < $1
wait

exec 3<&-
exec 3>&-

wait
