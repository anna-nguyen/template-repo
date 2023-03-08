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

cd $HOME/example-repo/
subdir="4-figures/"

for r_script in `ls $subdir*.R`
do 
  R CMD BATCH --no-save $r_script ${r_script%.*}.out
done
