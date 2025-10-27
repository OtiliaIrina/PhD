#!/bin/bash

#SBATCH -C cpu
#SBATCH --qos=regular
#SBATCH --time=02:00:00  # 2 hours
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --job-name=picca_cf
#SBATCH --output=/global/u1/o/otilia/PhD/test/picca_cf_%j.out

# Load Python and activate your Picca environment
module load python
conda activate picca_env

# Set Picca base (in case it’s not set already)
export PICCA_BASE="/global/u1/o/otilia/PhD/picca"

echo "Starting PICCA CF job on $(date)"

# Run PICCA CF
srun -n 32 picca_cf.py \
  --in-dir /global/u1/o/otilia/PhD/test/Delta_test \
  --out /global/u1/o/otilia/PhD/test/correlation_test.fits \

echo "Finished PICCA CF job on $(date)"

