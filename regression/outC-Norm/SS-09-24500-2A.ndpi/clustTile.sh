
#BSUB -J "SS-09-24500-2A.ndpi"
#BSUB -o output/SS-09-24500-2A.ndpi.%J
#BSUB -e errors/SS-09-24500-2A.ndpi.%J
#BSUB -n 1
#BSUB -P DMPYXYAAO
#BSUB -W 15:00
startRowByRowTile.sh
startFinalTile.sh
