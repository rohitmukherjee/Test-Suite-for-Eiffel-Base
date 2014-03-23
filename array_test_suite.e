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
			test_has

			-- Measurement Tests
			test_lower
			test_upper
			test_count
			test_capacity
			test_occurences
			test_index_set

			-- Comparison Tests
			test_is_equal_same_array
			test_is_equal_equal_arrays
			test_is_equal_unequal_arrays
			test_all_default
			test_filled_with
			test_full_empty_array
			test_full_non_empty_array
			test_same_items
			test_void_index
			test_extendible
			test_prunable

			-- Element Change Tests
			test_put
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
				print_test_passed ("make")
			ensure
				across array_under_test as element all element.item = default_value  end
			end

test_make_from_array
			-- Test for make_from_array creation procedure
			do
				create array_under_test_2.make_from_array (array_under_test)
				print_test_passed ("make_from_array")
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
				print_test_passed ("make_from_special")
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
					then print_test_passed ("@")
					else
					     print_test_not_passed ("@")
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
				print_test_passed ("put")
			ensure
				across array_under_test_2 as element all element.item = 2 * default_value end
			end

test_lower
			-- Test lower attribute of ARRAY
			local
				array_under_lower_test: ARRAY[INTEGER]
			do
				create array_under_lower_test.make_filled (default_value, -999, 1000)
				if array_under_lower_test.lower = -999
				then print_test_passed ("lower")
				else
					print_test_not_passed ("lower")
				end
			end

test_upper
			-- Test upper attribute of ARRAY
			local
				array_under_upper_test: ARRAY[INTEGER]
			do
				create array_under_upper_test.make_filled (default_value, -999, 1000)
				if array_under_upper_test.upper = 1000
				then print_test_passed ("upper")
				else
					print_test_not_passed ("upper")
				end
			end

test_count
			-- Test count attribute of ARRAY
			local
				array_under_count_test: ARRAY[INTEGER]
			do
				create array_under_count_test.make_filled (default_value, -999, 1000)
				if array_under_count_test.count = 2000
				then print_test_passed ("count")
				else
					print_test_not_passed ("count")
				end
			end

test_capacity
			-- Test capacity attribute of ARRAY
			local
				array_under_capacity_test: ARRAY[INTEGER]
			do
				create array_under_capacity_test.make_filled (default_value, -999, 1000)
				if array_under_capacity_test.capacity = 2000
				then print_test_passed ("capacity")
				else
					print_test_not_passed ("capacity")
				end
			end

test_occurences
			-- Test occurences feature of ARRAY
			local
				array_under_occurences_test: ARRAY[INTEGER]
				i: INTEGER
			do
				create array_under_occurences_test.make_filled (default_value, -999, 1000)
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
				then print_test_passed ("occurences")
				else
					print_test_not_passed ("occurences")
				end
			end

test_index_set
			-- Test index_set feature of Arrays
			local
				array_index_set: ARRAY[INTEGER]
				index_set_returned: INTEGER_INTERVAL
			do
				create array_index_set.make_filled (default_value, -999, 1000)
				index_set_returned := array_index_set.index_set
				if (index_set_returned.upper = 1000 and index_set_returned.lower = -999) then
					print_test_passed ("index_set")
				else
					print_test_not_passed ("index_set")
				end
			end

test_is_equal_same_array
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
			local
				array1: ARRAY[INTEGER]
			do
				create array1.make_filled (default_value, -999, 1000)
				if array1.is_equal (array1)
					then print_test_passed ("is_equal_same_array")
				else print_test_not_passed ("is_equal_same_array")
				end
			end

test_is_equal_equal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
			local
				array1: ARRAY[INTEGER]
				array2: ARRAY[INTEGER]
			do
				create array1.make_filled (default_value, -999, 1000)
				create array2.make_from_array (array1)
				if array1.is_equal (array2)
					then print_test_passed ("is_equal_equal_arrays")
				else print_test_not_passed ("is_equal_equal_arrays")
				end
			end

test_is_equal_unequal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
			local
				array1: ARRAY[INTEGER]
				array2: ARRAY[INTEGER]
			do
				create array1.make_filled (default_value, -999, 1000)
				create array2.make_filled (2 * default_value, -998, 1000)
				if  not array1.is_equal (array2)
					then print_test_passed ("is_equal_unequal_arrays")
				else print_test_not_passed ("is_equal_unequal_arrays")
				end
			end

test_all_default
			-- Test to check if an array contains all default_values
			-- TODO: Test is failing although the array has default_values
			local
				array: ARRAY[INTEGER]
			do
				create array.make_filled (default_value, -999, 1000)
				if array.all_default then
					print_test_passed ("all_default")
				else
					print_test_not_passed ("all_default")
				end
			end

test_filled_with
			-- Test to check if an array is filled with a certain value
			local
				array: ARRAY[INTEGER]
			do
				create array.make_filled (default_value, -999, 1000)
				if array.filled_with (default_value)
				then print_test_passed ("filled_with")
				else
					print_test_not_passed("filled_with")
				end
			end

test_full_empty_array
			-- Test should always return true for any array
			local
				array: ARRAY[INTEGER]
			do
				create array.make_empty
				if array.full then
					print_test_passed("full_empty_array")
				else
					print_test_not_passed ("full_empty_array")
				end
			end

test_full_non_empty_array
			-- Test should always return true for any array
			local
				array: ARRAY[INTEGER]
			do
				create array.make_from_array (array_under_test)
				if array.full then
					print_test_passed("full_non_empty_array")
				else
					print_test_not_passed ("full_non_empty_array")
				end
			end

test_same_items
			-- Tests same_items feature of an array
			do

			end

test_void_index
			-- Tests void Index feature of an array
			do

			end

test_extendible
			-- Always returns False
			do

			end
test_prunable
			-- Always returns False
			do

			end

feature
			-- All helper features go here

print_new_line
			--Prints a new line character
			do
				print("%N")
			end

print_test_passed(a_test_name: STRING)
			do
				print(a_test_name + " test passed%N")
			end

print_test_not_passed(a_test_name: STRING)
			do
				print(a_test_name + " test not passed%N")
			end

print_header
			-- Prints the header for the test suite
			do
				print("------------------------%N")
				print("Running Array Test Suite%N")
				print("------------------------%N")
			end
end
