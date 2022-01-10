MAX_TESTS=100
FAILED=0

RED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m'
MAKE_PATH=~/make/root/bin/make

for i in $(eval echo {1..$MAX_TESTS})
	do
		if [ -d test$i ]
			then
				cd test$i
				echo -n Test $i...
				$MAKE_PATH --gen-depgraph=out.dot > make_output.txt 2>&1
				sort out.dot > sorted_out.dot
				sort exp.dot > sorted_exp.dot
				diff sorted_out.dot sorted_exp.dot > diff.txt
				if [ $? -eq 0 ]
					then
						echo -e "${GREEN}PASSED${NC}"
					else
						echo -e "${RED}FAILED${NC}"
						FAILED=1
				fi
				cd ..
		fi
	done


if [ $FAILED -eq 1 ]
then
	echo -e "${RED}Check out diff files for more failure info\nNOTE: diff is between sorted versions${NC}\n"
else
	echo -e "${GREEN}All passed!${NC}\n"
fi


rm -f -r tmp
mkdir tmp
cp -R test1 ./tmp
cd ./tmp/test1
rm *.dot

echo -n "Testing with flag not given..."
$MAKE_PATH > /dev/null 2>&1
if [ -e *.dot ]
	then
		echo -e "${RED}FAILED - your program creates a .dot when it shouldn't${NC}"
	else
		echo -e "${GREEN}PASSED - well done, you know when you are not wanted${NC}"
fi

echo -n "Testing overwrite existing .dot file..."
touch out.dot
echo "Linus" > out.dot
$MAKE_PATH --gen-depgraph=out.dot > /dev/null 2>&1
grep -q "Linus" out.dot
if [ $? -eq 0 ]
	then
		echo -e "${RED}FAILED - you didn't overwrite the file${NC}"
	else
		echo -e "${GREEN}PASSED - you showed that file who's boss${NC}"
fi

echo -n "Testing fail to create .dot file..."
rm a b c
$MAKE_PATH --gen-depgraph=./notexist/a.dot > /dev/null 2>&1
MAKERET=$?
cat a b c > /dev/null
if [ $? -eq 0 ] && [ $MAKERET -eq 0 ]
	then
		echo -e "${GREEN}PASSED - nothing smart to say this time. Good job${NC}"
	else
		echo -e "${RED}FAILED - \"make\" failed because you failed to create the file${NC}"
		
fi
cd ../..
rm -f -r tmp

