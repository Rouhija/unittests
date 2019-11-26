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

if [ $# -ne 2 ]; then
	printf "$CYAN%s\n" "fillit: usage: ./run.sh <project-folder> <action>"
	exit 1
fi

if [ $2 = "comp" ] ; then
	cd ../$1
	make fclean
	make 
	make clean
	exit 1
fi

if test -f "../$1/author"; then
	printf "$PINK%s\n%s\n" "Authors:" $(cat ../$1/author)
else
	printf "$RED%s\n" "error: no author file"
fi

if [ $2 = "valid" ] || [ $2 = "all" ] ; then
	printf "$PINK%s$NORMAL\n" "BASIC TESTS"
	i=0
	while [ $i -le 19 ]
	do
		OUR=$(../$1/fillit valid_file/valid_$i)

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

if [ $2 = "error" ] || [ $2 = "all" ] ; then
	printf "$PINK%s$NORMAL\n" "ERROR HANDLING"
	x=0
	while [ $x -le 31 ]
	do
		OUR=$(../$1/fillit ./error_file/error_$x)
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

if [ $2 = "hard" ] || [ $2 = "all" ] ; then
	printf "$PINK%s$NORMAL\n" "HARD TESTS"
	x=0
	while [ $x -le 3 ]
	do
		OUR=$(../$1/fillit ./valid_file/hard_$x)
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