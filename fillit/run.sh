#!/bin/sh

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

varfolder=$(../select ../*)
sleep 1

if test -f "../../$varfolder/author"; then
	printf "$PINK%s\n%s\n" "Authors:" $(cat ../../$varfolder/author)
else
	printf "$RED%s\n" "error: no author file"
fi

while [ 1 -le 3 ]
do
	printf "$WHITE"
	echo "options:\n\t1 - basic tests\n\t2 - error tests\n\t3 - hard tests\n\t4 - compile"
	read vartest

	if [ $vartest = "4" ] ; then
		cd ../../$varfolder
		make fclean
		make 
		make clean
		cd -
	fi

	if [ $vartest = "1" ] ; then
		printf "$PINK%s$NORMAL\n" "BASIC TESTS"
		i=0
		while [ $i -le 19 ]
		do
			OUR=$(../../$varfolder/fillit valid_file/valid_$i)

			CORRECT=$(cat correct_compare/output_valid_$i)

			if [ "$OUR" != "$CORRECT" ]; then
				printf "$YELLOW%s$NORMAL\n" "TEST $i"
				printf "$RED%s$NORMAL\n" "[FAIL]"
				printf "$OUR\n"
				printf "$RED%s$NORMAL\n" "CORRECT RESULT"
				cat correct_compare/output_valid_$i
			else
				printf "%s %02s $GREEN%s$NORMAL\n" "Test" "$i" "[OK]"
			fi
			i=$(( $i + 1 ))
		done
		printf "\n"
	fi

	if [ $vartest = "2" ] ; then
		printf "$PINK%s$NORMAL\n" "ERROR HANDLING"
		x=0
		while [ $x -le 31 ]
		do
			OUR=$(../../$varfolder/fillit ./error_file/error_$x)
			CORRECT=error

			if [ "$OUR" != "$CORRECT" ]; then
				printf "$YELLOW%s$NORMAL\n" "TEST $x"
				printf "$RED%s$NORMAL\n" "[FAIL]"
				printf "$OUR\n"
			else
				printf "%s %02s $GREEN%s$NORMAL\n" "Test" "$x" "[OK]"
			fi
			x=$(( $x + 1 ))
		done
		printf "\n"
	fi

	if [ $vartest = "3" ] ; then
		printf "$PINK%s$NORMAL\n" "HARD TESTS"
		x=0
		while [ $x -le 3 ]
		do
			OUR=$(../../$varfolder/fillit ./valid_file/hard_$x)
			CORRECT=$(cat correct_compare/hard_valid_$x)

			if [ "$OUR" != "$CORRECT" ]; then
				printf "$YELLOW%s$NORMAL\n" "TEST $x"
				printf "$RED%s$NORMAL\n" "[FAIL]"
				printf "$OUR\n"
			else
				printf "%s %02s $GREEN%s$NORMAL\n" "Test" "$x" "[OK]"
			fi
			x=$(( $x + 1 ))
		done
		printf "\n"
	fi
done
