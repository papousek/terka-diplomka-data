set -x
while read PAIR; do
	EN=`echo $PAIR | awk -F ";" '{print $1}'`;
	CS=`echo $PAIR | awk -F ";" '{print $2}'`;
	for FILE in input/zasedani*.csv; do
		sed -i 's/'${CS}'/'${EN}'/g' $FILE
	done

done < input/preklad.csv
