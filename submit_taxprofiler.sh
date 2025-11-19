#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=abc123@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=eces450650prj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=1
### select number of cpus per task (you need to tweak this when you run a multi-thread program)
#SBATCH --cpus-per-task=1
### request 1 hour of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good esitmation of the run time though).
#SBATCH --time=01:00:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=12GB
### select the partition "edu" (this is the default partition but you can change according to your application)
#SBATCH --partition=edu


### Whatever modules you used (e.g. picotte-openmpi/gcc)
### must be loaded to run your code.
### Add them below this line.

module load nextflow

# Clean up any previous failed runs
nextflow clean -f
### The commands you want to run in this job script (run a python script, run a certain software with inputs and outpus etc.).
nextflow run nf-core/taxprofiler -r 1.1.0 \
  -profile singularity \
  --input samplesheet.csv \
  --databases database.csv \
  --outdir ./results2 \
  --perform_shortread_qc \
  --perform_shortread_hostremoval \
  --hostremoval_reference GCF_000819615.1_ViralProj14015_genomic.fna.gz \
  --perform_runmerging \
  --save_runmerged_reads \
  --run_centrifuge \
  --run_kaiju \
  --run_kraken2 \
  --run_profile_standardisation
