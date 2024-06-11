#!/bin/bash

#SBATCH --partition=longjobs                    # Partition
#SBATCH --nodes=1
#SBATCH --ntasks=2                              # Number of tasks (processes)
#SBATCH --time=14-00:00:00                           # Walltime
#SBATCH --job-name=ultimate_MH_file1_tun1.8
#SBATCH --output=apolo_info/%x_%j.out                   # Stdout (%x-jobName, %j-jobId)
#SBATCH --error=apolo_info/%x_%j.err                    # Stderr (%x-jobName, %j-jobId)
#SBATCH --mail-type=ALL                         # Mail notification
#SBATCH --mail-user=jdrengifoc@eafit.edu.co       # User Email

##### ENVIRONMENT CREATION #####
module load python/3.6.0_miniconda-4.3.11_gcc-11.2.0
source activate abc4sfa

##### JOB COMMANDS #### 
Rscript ./tempfolder/code_file1_tun1.8.R