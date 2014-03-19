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
		end


feature -- All attributes used during testing go here

array_under_test: ARRAY[INTEGER]

-- Tests for Creation Procedures

test_make_empty
			-- Test for make_empty creation procedure
		do
			create array_under_test.make_empty
			print("make_empty test passed%N")
		ensure
			array_under_test /= Void
		end

test_make_filled
			-- Test for make_filled creation procedure
			do
				create array_under_test.make_filled (0, 10, 1000)
				print("make_filled test passed%N")
			ensure
				array_under_test[55] = 0
			end

-- Helper Features

print_header
			-- Prints the header for the test suite
			do
				print("------------------------%N")
				print("Running Array Test Suite%N")
				print("------------------------%N")
			end
end
