# @param specific folders to re-run, runs entire project when no parameters provided
#    ex) sh ./run-project.sh 1-dm 3-tables

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
  
# By default, when no parameters are provided, run all folders numbered 1-9
if [ $# -eq 0 ];
then
  folders=$(ls -d [1-9]*)
else
  # Otherwise, read parameters
  folders=$@
fi

# Iterate through default folders or folders passed in as parameters
for subdir in $folders; do
  for r_script in `ls $subdir/*.R`   # Run all R scripts in sub-directory
    do 
      R CMD BATCH --no-save $r_script ${r_script%.*}.out
    done
    break
done

