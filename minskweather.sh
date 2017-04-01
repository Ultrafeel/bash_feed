#!/bin/bash

# echo "123 abc" | sed -r 's/[0-9]+/& &/'
#  echo "123 abc" | sed  's/\[0-9\]+/& &/'

#printf  "aaa\n\
#aaa\n\
#b\n\
#c\n\
#d\n\
#abc12345xyz\n\
#a\n\
#b\n\
#c\n\
#d"\
#|  sed -rnz 's/.*?b(.*)c./_\1\@/gp'
# sed -rnz 's/.*?b(.*)c./_\1\@/gp'
#|  sed -rn 's/.*?abc([0-9]+)xyz.*?/\1/gp'

var0=0
LIMIT=10


while [ "$var0" -lt "$LIMIT" ]
do
	echo "$var0 "
	var0=`expr $var0 + 1`
	wget http://www.pogoda.by/26850 -q -O - | iconv -t utf8 -f WINDOWS-1251\
	|grep -Pzo "(?s)<h2>Фактическая погода</h2>(.*?)</td>"\
	|  sed -rnz 's|.*</h2>(.*)</td>|_\1\_\n|gp' | sed "s/<br>/\n/g; s/<[^>]\+>//g"
	sleep 2
	#$(var0)=$(($(var0)+1))
done

#|  sed -rnz 's|.*<td[^>]*>.*<h2>Фактическая погода</h2>(.*)|.</td>.*|_\1\@|gp; '
#| grep -P --after-context=1  '<td[^>]*>[+-]\d+[.][.][+-]\d+</td>'


#'[+-]\d+[.][.][+-]\d+</td>' [^>]*>'
#'[+-][[:digit:]]+[.][.][+-][[:digit:]]+</td>'
# -A 2 -B 2 
# --after-context=1 
#-q -O -ls
# '[+-][[:digit:]]+[.][.][+-][[:digit:]]+'
# //td[>][^>]*

#<td class="dat" width="7%" bgcolor="#F2F2FF">вечер, ср.<br>29 марта</td>

#<td valign="top">
#<!-- если есть фактическая погода. если нет, то ближайшие -->
#<h2>Фактическая погода</h2>
#<p>
#<strong>Минск</strong>   за 15:00 UTC<br>Температура воздуха +5.9°C<br>Ветер 1 м/с,  северо-западный<br>Сплошная облачность <br>Влажность 49%<br>Давление 1011 гПа <font color="#999999">[758 мм]</font>, падает</p>
#</td>

	
