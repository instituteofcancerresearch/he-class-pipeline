
#BSUB -J "SS-08-12436-1A.ndpi"
#BSUB -o output/SS-08-12436-1A.ndpi.%J
#BSUB -e errors/SS-08-12436-1A.ndpi.%J
#BSUB -n 1
#BSUB -P DMPYXYAAO
#BSUB -W 15:00
startRowByRowTile.sh
startFinalTile.sh
