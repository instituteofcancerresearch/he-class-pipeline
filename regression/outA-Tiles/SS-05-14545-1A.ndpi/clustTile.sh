
#BSUB -J "SS-05-14545-1A.ndpi"
#BSUB -o output/SS-05-14545-1A.ndpi.%J
#BSUB -e errors/SS-05-14545-1A.ndpi.%J
#BSUB -n 1
#BSUB -P DMPYXYAAO
#BSUB -W 15:00
startRowByRowTile.sh
startFinalTile.sh
