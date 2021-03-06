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

vartest=$(./ft_select gnl fillit ft_printf ptfleaks)

if [ $vartest = "./gnl" ]; then
	cd gnl
	./run.sh
	exit 1
fi

if [ $vartest = "./fillit" ]; then
	cd fillit
	./run.sh
	exit 1
fi

if [ $vartest = "./ft_printf" ]; then
	cd ft_printf
	./start.sh
	./test_printf a
	exit 1
fi

if [ $vartest = "./ptfleaks" ]; then
	cd ft_printf
	./start.sh
	./test_printf l &
	sleep 2
	leaks test_printf
	kill $!
	exit 1
fi
