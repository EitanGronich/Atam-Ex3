Usage:
chmod +x test.sh
./test.sh

Details:
In each test folder there is a makefile and an expected .dot file.
Note: I made some assumptions on the format of the .dot file that might make your tests fail:
1. Newline at end of file
2. Every dependency line starts with a tab character "\t"
Apart from that, the order of the lines shouldn't matter (shouldn't make the test fail)

Additional tests:
"Testing with flag not given" - checks that if you dont get the flag, you dont make the .dot
"Testing overwrite existing .dot file..." - checks that if an existing file the same name exists, you overwrite it
"Testing fail to create .dot file..." - checks that if you fail to create the .dot file (for example with a 
path that has directories that don't exist) you let make finish correctly.


You are welcome to think of more edge cases and send them to me!
