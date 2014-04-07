note
	description: "Tests for ARRAY data structures"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("Array")

				-- Creation Procedure Tests
			test_make_empty
			test_make_filled
			test_make_from_array
			test_make_from_special
			test_make_from_cil --TODO

				-- Access Tests
			test_access
			test_has --TODO

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
			test_all_default_true_case
			test_all_default_false_case
			test_filled_with_true_case
			test_filled_with_false_case
			test_full_empty_array
			test_full_non_empty_array
			test_same_items_same_array
			test_same_items_equal_arrays
			test_same_items_unequal_arrays
			test_valid_index_empty_array
			test_valid_index_within_bounds
			test_valid_index_not_within_bounds
			test_extendible_empty_array
			test_extendible_non_empty_array
			test_prunable_empty_array
			test_prunable_non_empty_array
			test_resizable --TODO
			test_valid_index_set_empty_array
			test_valid_index_set_non_empty_array

				-- Element Change Tests
			test_put

				-- Removal Tests
			test_discard_items
			test_clear_all
			test_keep_head_valid_case
			test_keep_head_invalid_case
			test_keep_tail_valid_case
			test_keep_tail_invalid_case
			test_remove_head_valid_case
			test_remove_head_invalid_case
			test_remove_tail_valid_case
			test_remove_tail_invalid_case

				-- Resizing Tests
				-- Conversion Tests
				-- Duplication Tests
		end

feature
	-- All attributes used during testing go here

	default_value: INTEGER
		once
			Result := 37
		end

	default_array: ARRAY [INTEGER]

	utilities: UTILITIES

feature
	-- Tests for features

	test_make_empty
			-- Test for make_empty creation procedure
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				is_empty: array.is_empty
			end
			utilities.print_test_passed ("make_empty")
		end

	test_make_filled
			-- Test for make_filled creation procedure
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				across array as element all element.item = default_value end
			end
			utilities.print_test_passed ("make_filled")
		end

	test_make_from_array
			-- Test for make_from_array creation procedure
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			check
				across array as element all element.item = default_value end
			end
			utilities.print_test_passed ("make_from_array")
		end

	test_make_from_special
			-- Test for make_from_special creation procedure
		local
			array: ARRAY [INTEGER]
			special: SPECIAL [INTEGER]
		do
			create special.make_filled (default_value, 100)
			create array.make_from_special (special)
			check
				across array as element all element.item = default_value end
			end
			utilities.print_test_passed ("make_from_special")
		end

	test_make_from_cil
			-- Test for make_from_cil creation procedure
		do
				-- TODO		: Have to figure out how to test this with .NET
		end

	test_access
			-- Test @ access functionality of ARRAY
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.put ((array @ 1) * (array @ 2), 3)
			check
				array @ 3 = (default_value * default_value)
			end
			utilities.print_test_passed ("@")
		end

	test_has
			-- Test has functionality of ARRAY
		do
		end

	test_put
			-- Test put functionality of ARRAY
		local
			i: INTEGER
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			from
				i := 0
			until
				i = 100
			loop
				array.put (2 * default_value, i)
				i := i + 1
			end
			check
				across array as element all element.item = 2 * default_value end
			end
			utilities.print_test_passed ("put")
		end

	test_lower
			-- Test lower attribute of ARRAY
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.lower = -999
			end
			utilities.print_test_passed ("lower")
		end

	test_upper
			-- Test upper attribute of ARRAY
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.upper = 1000
			end
			utilities.print_test_passed ("higher")
		end

	test_count
			-- Test count attribute of ARRAY
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.count = 2000
			end
			utilities.print_test_passed ("count")
		end

	test_capacity
			-- Test capacity attribute of ARRAY
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.capacity = 2000
			end
			utilities.print_test_passed ("capacity")
		end

	test_occurences
			-- Test occurences feature of ARRAY
		local
			array: ARRAY [INTEGER]
			i: INTEGER
		do
			create array.make_filled (default_value, -999, 1000)
			from
				i := -999
			until
				i = 1000
			loop
				if i >= 0 then
					array.put (1, i)
				end
				i := i + 1
			end
			check
				array.occurrences (1) = 1000
			end
			utilities.print_test_passed ("occurences")
		end

	test_index_set
			-- Test index_set feature of Arrays
		local
			array_index_set: ARRAY [INTEGER]
			index_set_returned: INTEGER_INTERVAL
		do
			create array_index_set.make_filled (default_value, -999, 1000)
			index_set_returned := array_index_set.index_set
			check
				index_set_within_bounds: index_set_returned.upper = 1000 and index_set_returned.lower = -999
			end
		end

	test_is_equal_same_array
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.is_equal (array)
			end
			utilities.print_test_passed ("is_equal_same_array")
		end

	test_is_equal_equal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array1: ARRAY [INTEGER]
			array2: ARRAY [INTEGER]
		do
			create array1.make_filled (default_value, -999, 1000)
			create array2.make_from_array (array1)
			check
				both_arrays_should_contain_same_elements: array1.is_equal (array2)
			end
		end

	test_is_equal_unequal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array1: ARRAY [INTEGER]
			array2: ARRAY [INTEGER]
		do
			create array1.make_filled (default_value, -999, 1000)
			create array2.make_filled (2 * default_value, -998, 1000)
			check
				both_arrays_should_not_be_equal: not array1.is_equal (array2)
			end
			utilities.print_test_passed ("is_equal_unequal_arrays")
		end

	test_all_default_true_case
			-- Test to check if an array contains all default_values
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (0, -999, 1000)
			check
				array_only_contains_default_values: array.all_default
			end
			utilities.print_test_passed ("all_default_true_case")
		end

	test_all_default_false_case
			-- Test to check the false case of all_default
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (0, -999, 1000)
			array.put (2 * default_value, 6)
			check
				array_does_not_only_contains_default_values: not array.all_default
			end
			utilities.print_test_passed ("all_default_false_case")
		end

	test_filled_with_true_case
			-- Test to check if an array is filled with a certain value
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.filled_with (default_value)
			end
			utilities.print_test_passed ("test_filled_with_true_case")
		end

	test_filled_with_false_case
			-- Test to check false result of filled_with feature of arrays
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			array.put (2 * default_value, 6)
			check
				not array.filled_with (default_value)
			end
			utilities.print_test_passed ("test_filled_with_false_case")
		end

	test_full_empty_array
			-- Test should always return True for any array
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				array.full
			end
			utilities.print_test_passed ("full_empty_array")
		end

	test_full_non_empty_array
			-- Test should always return True for any array
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			check
				array.full
			end
			utilities.print_test_passed ("full_non_empty_array")
		end

	test_same_items_same_array
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				array.same_items (array)
			end
			utilities.print_test_passed ("same_items_same_array")
		end

	test_same_items_equal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array1: ARRAY [INTEGER]
			array2: ARRAY [INTEGER]
		do
			create array1.make_filled (default_value, -999, 1000)
			create array2.make_from_array (array1)
			check
				array1.same_items (array2)
			end
			utilities.print_test_passed ("same_items_equal_arrays")
		end

	test_same_items_unequal_arrays
			-- This tests if two arrays contain equal elements. Three cases have to be tested
			-- array.is_equal(array) should be true, array.is_equal(array2 with same elements) should be true
			-- and array.is_equal(different array) should return false
			-- At the moment, all three results are && -ed and then asserted. Will probably extract into
			-- individual test cases with better naming conventions
		local
			array1: ARRAY [INTEGER]
			array2: ARRAY [INTEGER]
		do
			create array1.make_filled (default_value, -999, 1000)
			create array2.make_filled (2 * default_value, -998, 1000)
			check
				not array1.same_items (array2)
			end
			utilities.print_test_passed ("same_items_unequal_arrays")
		end

	test_valid_index_empty_array
			-- Tests valid_index feature of an empty array
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				not array.valid_index (-999)
			end
			utilities.print_test_passed ("valid_index_empty_array")
		end

	test_valid_index_within_bounds
			-- Tests valid_index feature for an index within array bounds
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				(array.valid_index (-999) and array.valid_index (1000) and array.valid_index (500))
			end
			utilities.print_test_passed ("valid_index_within_bounds")
		end

	test_valid_index_not_within_bounds
			-- Tests valid_index feature for an index within array bounds
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, -999, 1000)
			check
				not array.valid_index (-9999)
			end
			utilities.print_test_passed ("valid_index_not_within_bounds")
		end

	test_extendible_empty_array
			-- Test should always return False for any array
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				not array.extendible
			end
			utilities.print_test_passed ("extendible_empty_array")
		end

	test_extendible_non_empty_array
			-- Test should always return False for any array
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			check
				not array.extendible
			end
			utilities.print_test_passed ("extendible_non_empty_array")
		end

	test_prunable_empty_array
			-- Test should always return False for any array
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				not array.prunable
			end
			utilities.print_test_passed ("prunable_empty_array")
		end

	test_prunable_non_empty_array
			-- Test should always return False for any array
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			check
				not array.prunable
			end
			utilities.print_test_passed ("prunable_non_empty_array")
		end

	test_resizable
			-- Test checks resizable feature of ARRAY
		do
		end

	test_valid_index_set_empty_array
			-- Test checks whether indexes are correctly set for empty ARRAYS
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			check
				array.valid_index_set
			end
			utilities.print_test_passed ("valid_index_set_empty_array")
		end

	test_valid_index_set_non_empty_array
			-- Test checks whether indexes are correctly set for empty ARRAYS
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			check
				array.valid_index_set
			end
			utilities.print_test_passed ("valid_index_set_non_empty_array")
		end

	test_discard_items
			-- Test resets all elements of array to their default values
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.discard_items
			check
				across array as element all element.item = 0 end
			end
			utilities.print_test_passed ("discard_items")
		end

	test_clear_all
			-- Test resets all elements of array to their default values
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.clear_all
			check
				across array as element all element.item = 0 end
			end
			utilities.print_test_passed ("clear_all")
		end

	test_keep_head_valid_case
			-- Test removes all elements except the first 'n'
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.keep_head (1)
			check
				new_size_is_correct: array.count = 1
				contents_are_correct: array.at (0) = default_value
			end
			utilities.print_test_passed ("keep_head_valid_case")
		end

	test_keep_head_invalid_case
			-- Test tries to keep the first element of an empty array
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			array.keep_head (300)
			check
				array.is_empty
			end
			utilities.print_test_passed ("keep_head_invalid_case")
		end

	test_keep_tail_valid_case
			-- Test removes all elements except last 'n'
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.keep_tail (50)
			check
				new_size_is_correct: array.count = 50
				contents_are_correct: array.at (99) = default_value
			end
			utilities.print_test_passed ("keep_tail_valid_case")
		end

	test_keep_tail_invalid_case
			-- Test tries to keep the last 100 elements in an array with one element
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_filled (default_value, 0, 0)
			array.keep_tail (100)
			check
				new_size_is_correct: array.count = 1
				contents_are_correct: array.at (0) = default_value
			end
			utilities.print_test_passed ("keep_tail_invalid_case")
		end

	test_remove_head_valid_case
			-- Tries to remove the first 'n' elements
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.remove_head (100)
			check
				new_size_is_correct: array.is_empty
			end
			utilities.print_test_passed ("remove_head_valid_case")
		end

	test_remove_head_invalid_case
			-- Tries to remove the first 'n' elements
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.remove_head (300)
			check
				new_size_is_correct: array.is_empty
			end
			utilities.print_test_passed ("remove_head_invalid_case")
		end

	test_remove_tail_valid_case
			-- Tries to remove the first 'n' elements
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.remove_tail (50)
			check
				new_size_is_correct: array.count = 50
				new_elements_are_correct: across array as element all element.item = default_value end
			end
			utilities.print_test_passed ("remove_tail_valid_case")
		end

	test_remove_tail_invalid_case
			-- Tries to remove the first 'n' elements
		local
			array: ARRAY [INTEGER]
		do
			setup_default_array
			create array.make_from_array (default_array)
			array.remove_tail (300)
			check
				new_size_is_correct: array.is_empty
			end
			utilities.print_test_passed ("remove_tail_invalid_case")
		end

feature
	-- All helper features go here

	setup_default_array
			-- Feature setups up default_array
		do
			create default_array.make_filled (default_value, 0, 99)
		end

end
