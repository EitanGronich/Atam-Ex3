MAX_TESTS=100

for i in $(eval echo {1..$MAX_TESTS})
	do
		if [ -d test$i ]
			then
				cd test$i
				rm -f a b c
				rm -f make_output.txt out.dot sorted_out.dot sorted_exp.dot diff.txt
				cd ..
		fi
	done
