#SBATCH --qos=regular
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32     
#SBATCH --job-name=cf_full_scratch
#SBATCH --output=/global/u1/o/otilia/PhD/logs/cf_full_%j.out
#SBATCH --mail-user=otilia.manasoiu.25@ucl.ac.uk
#SBATCH --mail-type=ALL


module load python
conda activate picca_env

export PICCA_BASE="/global/u1/o/otilia/PhD/picca"

# Define directories
RUN_DIR=$SCRATCH/picca_runs/cf_full_${SLURM_JOB_ID}
OUT_DIR_PERM=/global/u1/o/otilia/PhD/CF
OUT_FILE=$RUN_DIR/cf_all.fits

mkdir -p $RUN_DIR
mkdir -p $OUT_DIR_PERM

echo "Starting PICCA CF job"
echo "Date: $(date)"
echo "Run directory: $RUN_DIR"
echo "Output file: $OUT_FILE"

cd $RUN_DIR


srun -n 32 picca_cf.py \
  --in-dir /global/cfs/cdirs/desicollab/users/lauracdp/photo-z_box/lya_mocks/mock_analysis/qq_desi_y5/skewers_desi_footprint.5/analysis-0/jura-0/raw/deltas_lya/Delta/ \
  --out $OUT_FILE

#  Copy results back to permanent storage
if [ -f "$OUT_FILE" ]; then
  cp $OUT_FILE $OUT_DIR_PERM/
  echo " CF results copied to $OUT_DIR_PERM"
else
  echo "WARNING: Output file not found. Check job logs."
fi

echo "Finished PICCA CF job on $(date)"
