#!/bin/bash

#estraggo il backbone composto dagli atomi CA,N,C utilizzando il comando grep
#utilizzando come pattern N CA e C
#la struttura dello script è molto simile a quella dell'esercizio3 con i dovuti
#accorgimenti riguardanti il calcolo degli atomi totali del backbone

input=$1
output="out-$1"$2

n_atom1=$(grep -E -w "C|CA|N" $input | wc -l) 
grep -E -w "C |CA |N " $input > traiettoria_xyz_temp.txt
model=$(grep "PROVA" $input | wc -l)
n_atom=$(($n_atom1/$model))

for X in $(seq 0 $(($model -1)));do
ta_1=$(($n_atom * $X + 1))
he_1=$((($X + 1) * $n_atom ))
echo -e $n_atom "\nPROVA " >> $output 
head -n$he_1 traiettoria_xyz_temp.txt | tail -n+$ta_1  >> $output
done

rm traiettoria_xyz_temp.txt


