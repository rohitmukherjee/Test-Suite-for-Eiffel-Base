note
	description: "Helper features which help in the presentation of content"
	date: "$Date$"
	revision: "$Revision$"

class
	UTILITIES


feature
			-- Features which aid in the printing/representation of content

print_new_line
			--Prints a new line character
			do
				print ("%N")
			end

print_test_passed (a_test_name: STRING)
			do
				print (a_test_name + " test passed%N")
			end

print_test_not_passed (a_test_name: STRING)
			do
				print (a_test_name + " test not passed%N")
			end

print_header (a_test_suite_name: STRING)
			-- Prints the header for the test suite
			do
				print ("------------------------%N")
				print ("Running " + a_test_suite_name + " Test Suite%N")
				print ("------------------------%N")
			end
end
