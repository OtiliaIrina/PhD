#!/bin/bash

#SBATCH -C cpu
#SBATCH --qos=regular
#SBATCH --time=00:01:00
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
  --in-dir /global/cfs/cdirs/desicollab/users/lauracdp/photo-z_box/lya_mocks/mock_analysis/qq_desi_y5/skewers_desi_footprint.5/analysis-0/jura-0/raw/deltas_lya/Delta \
  --out /global/u1/o/otilia/PhD/test/correlation.fits \
  --r-min 0 \
  --r-max 200 \
  --dr 4 \
  --z-min 1.9 \
  --z-max 3.5

echo "Finished PICCA CF job on $(date)"
