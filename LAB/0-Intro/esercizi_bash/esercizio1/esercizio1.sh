#!/bin/bash
#prende in input un file passato da linea di comando
#il comando cat legge il/i file indicati 
#crea un file con tutte le righe contenenti MODEL, ATOM, TER, ENDMDL (grep -E -w "MODEL  |ATOM |TER  |ENDMDL" ):
#1)l'opzione -E permette di inserire più pattern di ricerca
#2)l'opzione -w permette di considerare esclusivamente le righe con la parola scelta
#il comando grep -v "REMARK" elimina tutte le righe contenenti la parola REMARK 

input=$1
output="out-$1"$2
cat $input | grep -E -w "MODEL  |ATOM |TER  |ENDMDL" | grep -v "REMARK" > $output




