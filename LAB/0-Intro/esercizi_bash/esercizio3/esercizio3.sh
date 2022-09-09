#!/bin/bash

#n_atom rappresenta il numero totale di atomi presenti in uno step(n.b. awk considera 
#solamente le righe in cui e presente ATOM)
#model rappresenta il numero totale di modelli
#ta_1 rappresenta i coefficienti da usare nella funzione tail 
#he_1 rappresenta i coefficienti da usare nella funzione head
#echo è il comando che permette di scrivere stringhe di testo
#il comando head ... | tail ... considera iterativamente gli atomi di ogni singolo step
#(al primo ciclo considera i primi 2916 atomi, al secondo considera dal 2917 al 5833 e così via ) 
#il comando >> scrive su file e sovrascrive il file se è già esistente
#rm è un comando che serve per rimuovere file

input=$1
output="out-$1"$2

n_atom=$(awk '/ATOM/ {if($2>max) {max=$2}} END {print max}' $input)
awk '/ATOM/ {print $3"  "$7" "$8" "$9}' $input > traiettoria_xyz_temp.txt
model=$(grep "MODEL" $input | wc -l)

for X in $(seq 0 $(($model -1)));do
ta_1=$(($n_atom * $X + 1))
he_1=$((($X + 1) * $n_atom))
echo -e $n_atom "\nPROVA " >> $output 
head -n$he_1 traiettoria_xyz_temp.txt | tail -n+$ta_1 >> $output
done

rm traiettoria_xyz_temp.txt
mv $output `echo $output | sed s/pdb/xyz/g`
