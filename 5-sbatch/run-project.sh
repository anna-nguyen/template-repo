#!/bin/bash

#SBATCH --job-name=run-example-repo
#SBATCH --begin=now
#SBATCH --dependency=singleton
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --mem=64G
#SBATCH --output=00-example-repo.out
#SBATCH --time=2-00:00:00

module purge 
module load R/4.0.2

sbatch_dir="5-sbatch/"
cd $HOME/example-repo/$sbatch_dir

for sh_script in `ls *.sh`
do 
  if [ $sh_script != "run-project.sh" ]; then
     sh ./$sh_script
  fi
done
