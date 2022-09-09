#!/bin/bash

#input1=file con i 10 step del backbone; input2=file con la media dei 10 step del backbone
#nel primo ciclo for copiamo 10 volte il contenuto del file bck_a... nel nuovo file di output
#il comando paste permette di affiancare il contenuto dei due file di input
#usiamo awk per formattare il testo, la scrittura %-6s significa che stampiamo almeno 6 caratteri partendo da sinistra
#analogamente la scrittura %-16f significa che stampiamo almeno 16 numeri partendo da sinistra
#per finire  utilizziamo awk dentro a un ciclo for per calcolare la rmsd(deviazione standard) lungo i tre assi
#(n.b.1  possiamo usare agevolmente awk perchè prima ci siamo creati il file "union_CA.txt"
# che ripete 10 volte la media degli atomi del backbone in modo da poter calcolare riga per riga rmsd dei 10 step)
#(n.b.2 awk lavora sulle righe del file riga per riga fino alla fine del file)

input1=$1
input2=$2

model=$(grep "MODEL" coord_atom.pdb | wc -l)
grep -w "CA" $input1 > back_bone_CA.txt
grep -w "CA" $input2 > bck_average_CA.txt

for Z in $(seq 1 $model);do
cat bck_average_CA.txt >> bck_average1_CA.txt
done

line_CA=$(cat  bck_average_CA.txt | wc -l)
paste back_bone_CA.txt bck_average1_CA.txt > union_CA.txt
awk '{printf "%-6s %-16f %-16f %-16f %-6s %-16f %-16f %-16f\n",$1,$2,$3,$4,$5,$6,$7,$8}' union_CA.txt > union_CA_form.txt
rm back_bone_CA.txt bck_average_CA.txt bck_average1_CA.txt union_CA.txt
line_CA_awk=$line_CA

for Q in $(seq 1 $model);do
awk -v line_CA="$line_CA" -v Q="$Q" -v L1="$line_CA_awk" '{if(NR<=line_CA && NR>=(Q-1)*L1){x_av=($2-$6)^2; y_av=($3-$7)^2; z_av=($4-$8)^2; N=N+1}} END{ rmsd=sqrt((x_av+y_av+z_av)/N); print " rmsd " Q " step: " rmsd}' union_CA_form.txt >> rmsd.txt
line_CA=$line_CA_awk
line_CA=$(($line_CA*$Q))
done



