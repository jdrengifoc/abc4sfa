#!/bin/bash
# Global varaibles.
scenario=s12
tun=1.1
temp_folder=./tempfolder
original_slurm=slurm_mh_longjobs.sh
original_rscript=code.R

update_slurm () {
  sed -i '' 's/s[0-9]*_tun[0-9]\.*[0-9]*/'"${scenario}"'_tun'"${tun}"'/g' $1
}

update_rscript() {
    sed -i '' 's|tun <- [0-9]\.*[0-9]*|tun <- '"$tun"'|' $1
    sed -i '' 's|scenarios <- c("s[0-9]*")|scenarios <- c("'"$scenario"'")|' $1
}

rm -r $temp_folder
mkdir $temp_folder

for unit in $(seq 1 1 16)
do
    # Update variables.
    scenario=s$unit
    new_slurm=${temp_folder}/slurm_${scenario}_tun${tun}.sh
    new_rscript=${temp_folder}/code${scenario}_tun${tun}.R
    # New modified files.
    cp $original_slurm $new_slurm
    cp $original_rscript $new_rscript
    update_slurm $new_slurm
    update_rscript $new_rscript

    sbatch $new_slurm
done