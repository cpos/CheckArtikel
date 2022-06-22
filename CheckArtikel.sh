#!/usr/bin/bash

####
# check connectivity 
####

VERSION="0.2"

wget -q --spider http://duden.de

if ! [ $? -eq 0 ]; then
    echo "duden.de ist nicht erreichbar ... Abgebrochen"
    exit 0
fi

####
# handle arguments 
####

if ! [ -z "$2" ]; then
    echo "CheckArtikel $VERSION (2022) von Chriss Posselt - https://github.com/cpos/CheckArtikel"
    echo ""
    echo "Die Anfrage für: \"$@\" kann nicht bearbeitet werden."
    echo "ERROR: Zu viele Wörter."
    echo ""
fi


if [ -z "$1" ]; then
    echo "CheckArtikel $VERSION (2022) von Chriss Posselt - https://github.com/cpos/CheckArtikel"
    echo ""
    echo "ERROR: Es muss ein Wort mit angegeben werden."
    echo "Beispiel: ./CheckArtikel.sh Kochtopf"
    echo ""
fi

####
# get duden.de page for $1
####

DUDENURL="https://www.duden.de/rechtschreibung/$1"

wget -q -O check.tmp $DUDENURL 

####
# print output 
####

cat check.tmp |grep "maskulin" > /dev/null

if [ $? -eq "0" ]; then
    echo "der \"$1\" (maskulin)"
    rm check.tmp
    exit 0
fi

cat check.tmp |grep "feminin" > /dev/null

if [ $? -eq "0" ]; then
    echo "die \"$1\" (feminin)"
    rm check.tmp
    exit 0
fi

cat check.tmp |grep "Neutrum" > /dev/null

if [ $? -eq "0" ]; then
    echo "das \"$1\" (Neutrum)"
    rm check.tmp
    exit 0
fi

echo "Kein Ergebnis auf duden.de für \"$1\""
rm check.tmp
