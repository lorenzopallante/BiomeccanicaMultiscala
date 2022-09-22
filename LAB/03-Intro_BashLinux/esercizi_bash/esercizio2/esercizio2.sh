#!/bin/bash
#prende in input un file da linea di comando
#awk permette di lavorare sulle righe di un file, riga per riga
#in questo caso consideriamo sole le righe con i pattern ATOM e TER, e stampiamo nel file output solo le colonne 2 e 3 ($2 $3) 
#la sintassi "   " serve per distanziare i valori della colonna 2 dalla colonna 3. 
#l'ultima istruzione serve per rinominare il file da pdb a txt

input=$1
output="out-$1"$2

awk '/ATOM |TER / {print  $2"  "$3 }' $input > $output
mv $output `echo $output | sed s/pdb/txt/g`

