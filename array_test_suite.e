note
	description : "Tests for ARRAY data structures"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ARRAY_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests

		do
			print_header
			test_make_empty
			test_make_filled
			test_make_from_array
		end


feature
			-- All attributes used during testing go here

default_value: INTEGER is 37
array_under_test: ARRAY[INTEGER]
array_under_test_2: ARRAY[INTEGER]

feature
			-- Tests for features

test_make_empty
			-- Test for make_empty creation procedure
		do
			create array_under_test.make_empty
			print("make_empty test passed%N")
		ensure
			array_under_test.is_empty = True
		end

test_make_filled
			-- Test for make_filled creation procedure
			do
				create array_under_test.make_filled (default_value, 10, 1000)
				print("make_filled test passed%N")
			ensure
				across array_under_test as element all element.item = default_value  end
			end

test_make_from_array
			-- Test for make_from_array creation procedure
			do
				create array_under_test_2.make_from_array (array_under_test)
				print("test_make_from_array passed%N")
			ensure
				across array_under_test_2 as element all element.item = default_value end
			end
feature
			-- All helper features go here

print_header
			-- Prints the header for the test suite
			do
				print("------------------------%N")
				print("Running Array Test Suite%N")
				print("------------------------%N")
			end
end
