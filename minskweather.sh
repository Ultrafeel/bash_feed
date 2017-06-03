#!/bin/bash

#var0=0
#LIMIT=100
#"$var0" -lt "$LIMIT" 

w=`cat config.ini`
if [ "$w" -lt "1" ]
then
	w=1
fi
echo "wait period = $w "
while [ 1 ]
do 
	# tr - used for temporary change \n to some symbol that cannot appear
	# and revert back
	#grep: (?s)
	#match the remainder of the pattern with the following effective flags: 
	#s modifier: single line. Dot matches newline characters
	var0=`expr $var0 + 1`
	echo " $var0."
	wget http://www.pogoda.by/26850 -q -O - | iconv -t utf8 -f WINDOWS-1251\
	|grep --text -Pzo "(?s)<h2>Фактическая погода</h2>(.*?)</td>"\
	| tr '\n' '\f'\
	| sed -rn 's|.*</h2>(.*)</td>|_\1\_\f|gp' | sed "s/<br>/\f/g; s/<[^>]\+>//g"\
	| tr '\f' '\n'\ 
	sleep $w
done

#<td valign="top">
#<!-- если есть фактическая погода. если нет, то ближайшие -->
#<h2>Фактическая погода</h2>
#<p>
#<strong>Минск</strong>   за 15:00 UTC<br>Температура воздуха +5.9°C<br>Ветер 1 м/с,  северо-западный<br>Сплошная облачность <br>Влажность 49%<br>Давление 1011 гПа <font color="#999999">[758 мм]</font>, падает</p>
#</td>


