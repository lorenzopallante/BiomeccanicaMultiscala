#!/bin/bash

# First of all, check if an argument has been given to the script
if [ ! -z $1 ]
then
    # In this case, the argument has been given. Let's store it in a variable
    wd=$1
    echo "I will work with pdb files in $wd"
else
    # The argument is missing. Terminate the script and inform the user about the problem
    echo "You must give the working directory as input"
    exit -1
fi

# Store in a variable the current working directory
# We will move from this folder, so we want to know where the script was exected to come back in this folder at the end of the script
# This is a good practice when scripting
cwd=$(pwd)
echo "The current working directory is $cwd"

# Here we move to the working directory 
cd $wd
# Let's insert a comment as a first line, with the identification of what each column contains
echo "#File_Name,Number_of_Residues" >$cwd/stat.csv
# Create an empty file where we will put the information about the file with the maximum number of residues
touch $cwd/maxres.stat

# Initialize some variables that will be used later
max=0
maxname=None

# Here, we cycle over all files with pdb extension in the working directory
for file in $(ls -f *.pdb)
do
    # Store in a variable the number of residues in this file
    natoms=$(cat $file | grep "ATOM" | grep "CA" | wc -l)
    
    # Add a line in the stat file
    echo "$file,$natoms" >> $cwd/stat.csv
    
    # Check if we have found a protein with a greater number of residues than the current maximum
    if [ $natoms -gt $max ]
    then
        max=$natoms
        maxname=$file
        echo "$maxname has the highest number of residues ($max)" > $cwd/maxres.stat
    fi
done

# As said before, it is a good practice to return in the initial folder
cd $cwd
