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

			-- Creation Procedure Tests
			test_make_empty
			test_make_filled
			test_make_from_array
			test_make_from_special
			test_make_from_cil

			-- Access Tests
			test_access
			test_put
			test_has

			-- Measurement Tests
			test_lower
			test_upper
			test_count
			test_capacity
			test_occurences
		end


feature
			-- All attributes used during testing go here

default_value: INTEGER
	once
       Result := 37
    end

array_under_test: ARRAY[INTEGER]
array_under_test_2: ARRAY[INTEGER]
array_under_test_3: ARRAY[INTEGER]
array_under_test_4: ARRAY[INTEGER]

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
				create array_under_test.make_filled (default_value, 0, 99)
				print("make_filled test passed%N")
			ensure
				across array_under_test as element all element.item = default_value  end
			end

test_make_from_array
			-- Test for make_from_array creation procedure
			do
				create array_under_test_2.make_from_array (array_under_test)
				print("make_from_array test passed%N")
			ensure
				across array_under_test_2 as element all element.item = default_value end
			end

test_make_from_special
			-- Test for make_from_special creation procedure
			local
				special: SPECIAL[INTEGER]
			do
				create special.make_filled (default_value, 100)
				create array_under_test_3.make_from_special(special)
				print("make_from_special test passed%N")
			ensure
				across array_under_test_3 as element all element.item = default_value end
			end

test_make_from_cil
			-- Test for make_from_cil creation procedure
			do
			-- TODO		: Have to figure out how to test this with .NET
			end


test_access
			-- Test @ access functionality of ARRAY
			do
				array_under_test.put ((array_under_test @ 1) * (array_under_test @ 2), 3)
					if	array_under_test @ 3 = (default_value * default_value)
					then print ("@ Test Passed%N")
					else
					     print ("@ Test Not Passed%N")
					     print("Expected Value:")
					     print(default_value * default_value)
					     print_new_line
					     print(array_under_test @ 3)
					     print_new_line
					end
			end

test_has
			-- Test has functionality of ARRAY
			do
			end

test_put
			-- Test put functionality of ARRAY
			local
				i: INTEGER
			do
				from
				  i := 0
				until
				  i = 100
				loop
				  array_under_test_2.put (2 * default_value, i)
				  i := i + 1
				end
				print("put test passed%N")
			ensure
				across array_under_test_2 as element all element.item = 2 * default_value end
			end

test_lower
			-- Test lower attribute of ARRAY
			local
				array_under_lower_test: ARRAY[INTEGER]
			do
				create array_under_lower_test.make_filled (-1, -999, 1000)
				if array_under_lower_test.lower = -999
				then print("lower test passed%N")
				else
					print ("lower test not passed%N")
				end
			end

test_upper
			-- Test upper attribute of ARRAY
			local
				array_under_upper_test: ARRAY[INTEGER]
			do
				create array_under_upper_test.make_filled (-1, -999, 1000)
				if array_under_upper_test.upper = 1000
				then print("upper test passed%N")
				else
					print ("upper test not passed%N")
				end
			end

test_count
			-- Test count attribute of ARRAY
			local
				array_under_count_test: ARRAY[INTEGER]
			do
				create array_under_count_test.make_filled (-1, -999, 1000)
				if array_under_count_test.count = 2000
				then print("count test passed%N")
				else
					print ("count test not passed%N")
				end
			end

test_capacity
			-- Test capacity attribute of ARRAY
			local
				array_under_capacity_test: ARRAY[INTEGER]
			do
				create array_under_capacity_test.make_filled (-1, -999, 1000)
				if array_under_capacity_test.capacity = 2000
				then print("capacity test passed%N")
				else
					print ("capacity test not passed%N")
				end
			end

test_occurences
			-- Test occurences feature of ARRAY
			local
				array_under_occurences_test: ARRAY[INTEGER]
				i: INTEGER
			do
				create array_under_occurences_test.make_filled (-1, -999, 1000)
				from
					i := -999
				until
					i = 1000
				loop
					if i>=0
					then array_under_occurences_test.put (1, i)
					end
					i := i + 1
				end
				if array_under_occurences_test.occurrences (1) = 1000
				then print("occurences test passed%N")
				else
					print("occurences test not passed%N")
				end
			end

feature
			-- All helper features go here

print_new_line
			--Prints a new line character
			do
				print("%N")
			end

print_header
			-- Prints the header for the test suite
			do
				print("------------------------%N")
				print("Running Array Test Suite%N")
				print("------------------------%N")
			end
end
