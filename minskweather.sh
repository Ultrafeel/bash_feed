#!/bin/bash

var0=0
LIMIT=100

w=`cat config.ini`
if [ "$w" -lt "1" ]
then
	w=1
fi
echo "wait preiod = $w "
while [ "$var0" -lt "$LIMIT" ]
do
	echo "$var0 "
	var0=`expr $var0 + 1`
	wget http://www.pogoda.by/26850 -q -O - | iconv -t utf8 -f WINDOWS-1251\
	|grep -Pzo "(?s)<h2>Фактическая погода</h2>(.*?)</td>"\
	|  sed -rnz 's|.*</h2>(.*)</td>|_\1\_\n|gp' | sed "s/<br>/\n/g; s/<[^>]\+>//g"
	sleep $var0 
done

#<td valign="top">
#<!-- если есть фактическая погода. если нет, то ближайшие -->
#<h2>Фактическая погода</h2>
#<p>
#<strong>Минск</strong>   за 15:00 UTC<br>Температура воздуха +5.9°C<br>Ветер 1 м/с,  северо-западный<br>Сплошная облачность <br>Влажность 49%<br>Давление 1011 гПа <font color="#999999">[758 мм]</font>, падает</p>
#</td>


