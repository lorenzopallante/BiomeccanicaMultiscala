#!/bin/bash

#il comando cat serve a visualizzare l'intero contenuto di un file
#line_bb rappresenta la lunghezza del backbone
#n_atom_bb rappresenta il numero di atomi del backbone per ogni step
#l'estensione -v del comando awk serve a passare delle variabili esterne alla funzione awk
#(n.b. awk non vede il contenuto delle variabili esterne)
#l'espressione END di awk permette di eseguire comandi dopo aver letto tutto il file

input=$1
output="average_$1"$2

model=$(grep "PROVA" $input | wc -l)
line_bb=$(cat  $input | grep -E -w "N|CA|C" | wc -l)
n_atom_bb=$(($line_bb/$model))

echo -e "$n_atom_bb \nPROVA" > $output
for mod in $(seq 1 $n_atom_bb);do
cat $input | grep -E -w "N|C|CA" | awk -v mod="$mod" -v n_atom_bb="$n_atom_bb" '{if(NR==mod){mod=mod+n_atom_bb; sumx=sumx+$2; sumy=sumy+$3; sumz=sumz+$4;count=count+1;atom=$1}} END{print atom,sumx/count,sumy/count,sumz/count}' >> $output
done

