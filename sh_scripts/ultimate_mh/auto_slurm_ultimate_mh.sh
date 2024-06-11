#!/bin/bash
# Global varaibles.
tun=1.8
# Paths
temp_folder=./tempfolder
if [[ "$OSTYPE" == "linux-gnu" ]]
then
    original_slurm=slurm_ultimate_mh_longjobs.sh
    original_rscript=Code/ultimate_metropolis-hasting_apolo.R 
else
    original_slurm=ultimate_mh/slurm_ultimate_mh_longjobs.sh
    original_rscript=ultimate_mh/ultimate_tun_metropolis-hasting_apolo.R
fi

update_slurm () {
    if [[ "$OSTYPE" == "linux-gnu" ]]
    then
        sed -i 's|file[0-9]*_tun[0-9]\.*[0-9]*|'"${file}"'_tun'"${tun}"'|g' $1
        sed -i 's|Code/ultimate_metropolis-hasting_apolo.R|'"${new_rscript}"'|g' $1
    else
        sed -i '' 's|file[0-9]*_tun[0-9]\.*[0-9]*|'"${file}"'_tun'"${tun}"'|g' $1
        sed -i '' 's|Code/ultimate_metropolis-hasting_apolo.R|'"${new_rscript}"'|g' $1
    fi
}

update_rscript() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sed -i 's|tun <- [0-9]\.*[0-9]*|tun <- '"$tun"'|' $1
        sed -i  's|file <- "file[0-9]*"|file <- "'"$file"'"|' $1
    else
        sed -i '' 's|tun <- [0-9]\.*[0-9]*|tun <- '"$tun"'|' $1
        sed -i '' 's|file <- "file[0-9]*"|file <- "'"$file"'"|' $1
    fi
}

rm -r $temp_folder
mkdir $temp_folder

for unit in $(seq 1 1 16)
do
    # Update variables.
    file=file$unit
    new_slurm=${temp_folder}/slurm_${file}_tun${tun}.sh
    new_rscript=${temp_folder}/code_${file}_tun${tun}.R
    # New modified files.
    cp $original_slurm $new_slurm
    cp $original_rscript $new_rscript
    update_slurm $new_slurm
    update_rscript $new_rscript

    #$sbatch $new_slurm
done