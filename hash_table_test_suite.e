note
	description: "Tests for HASH_TABLE data structure"
	date: "$Date$"
	revision: "$Revision$"

class
	HASH_TABLE_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("HASH_TABLE")

				-- Creation Tests
			test_make

				-- Access Tests
			test_accomodate
			test_has_false
			test_has_true
			test_has_key_true
			test_has_key_false
			test_has_item_true
			test_has_item_false
			test_item_found
			test_current_keys
			test_item_for_iteration
			test_key_for_iteration
			test_iteration_item

				-- Measurement Tests
			test_count
			test_capacity
			test_occurences
			test_iteration_index_set

				-- Comparison Tests
			test_same_keys_true
			test_same_keys_false
			test_is_equal_true
			test_is_equal_false
			test_disjoint_true
			test_disjoint_false

				-- Status Report Tests
			test_full
			test_extendible
			test_prunable
			test_inserted_true
			test_inserted_false
			test_replaced_true
			test_replaced_false
			test_removed_true
			test_removed_false
			test_found_false
			test_found_true
			test_not_found_true
			test_not_found_false
			test_off_true
			test_off_false
			test_valid_key_true
			test_valid_key_false
			test_valid_iteration_index_true
			test_valid_iteration_index_false

			-- Cursor Movement Tests
			test_start
			test_forth
			test_search_found
			test_search_not_found
		end

feature
	-- All attributes used during testing go here

	utilities: UTILITIES

	default_size: INTEGER
		once
			Result := 10
		end

	default_key: INTEGER
		once
			Result := 37
		end

	default_value: INTEGER
		once
			Result := 74
		end

feature
	-- Tests go here

	test_make
			-- Tests make feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			check
				table /= Void
			end
			utilities.print_test_passed ("make")
		end

	test_accomodate
			-- Tests accomodate feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.accommodate (2)
			table.put (default_key * 2, default_value)
			check
				table.has (default_value)
			end
			utilities.print_test_passed ("accomodate")
		end

	test_has_false
			-- Tests has feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				should_be_false: table.has (3000) = False
			end
			utilities.print_test_passed ("has_false")
		end

	test_has_true
			-- Tests has feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				table.has (2 * default_key)
			end
			utilities.print_test_passed ("has_true")
		end

	test_has_key_false
			-- Tests has_key feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				not table.has (3000)
			end
			utilities.print_test_passed ("has_key_false")
		end

	test_has_key_true
			-- Tests has feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				table.has (2 * default_key)
			end
			utilities.print_test_passed ("has_key_true")
		end

	test_has_item_true
			-- Tests has_item feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				not table.has_item (default_value)
			end
		end

	test_has_item_false
			-- Tests has_item feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_key, default_value)
			table.put (default_key * 2, default_value)
			check
				not table.has_item (2 * default_value)
			end
		end

	test_item_found
			-- Tests the item feature of HASH_TABLE for found case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (1)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			check
				table.item (default_key) = default_value
				table.item (2 * default_key) = 2 * default_value
			end
			utilities.print_test_passed ("item_found")
		end

	test_current_keys
			-- Tests the current_keys fature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
			keys: ARRAY [INTEGER]
		do
			create table.make (10)
			table.put (default_value, default_key)
			table.put (default_value, 2 * default_key)
			table.put (default_value, 3 * default_key)
			table.put (default_value, 4 * default_key)
			keys := table.current_keys
			check
				size_is_correct: keys.count = 4
				contains_element_1: keys.has (default_key)
				contains_element_1: keys.has (2 * default_key)
				contains_element_1: keys.has (3 * default_key)
				contains_element_1: keys.has (4 * default_key)
			end
			utilities.print_test_passed ("current_keys")
		end

	test_item_for_iteration
			-- Tests item_for_iteration feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (10)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			table.start
			check
				table.item_for_iteration = default_value
			end
			utilities.print_test_passed ("item_for_iteration")
		end

	test_key_for_iteration
			-- Tests item_for_iteration feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (10)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			table.start
			check
				table.key_for_iteration = default_key
			end
			utilities.print_test_passed ("key_for_iteration")
		end

	test_iteration_item
			-- Tests iteration_item feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (10)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			table.start
			check
				table.iteration_item (1) = 2 * default_value
			end
			utilities.print_test_passed ("iteration_item")
		end

	test_count
			-- Tests the count feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			check
				table.count = 2
			end
			utilities.print_test_passed ("count")
		end

	test_capacity
			-- Tests the capacity feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.put (2 * default_value, 2 * default_key)
			check
				table.capacity = 17
			end
			utilities.print_test_passed ("capacity")
		end

	test_occurences
			-- Tests the occurences feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.put (default_value, 2 * default_key)
			check
				table.occurrences (default_value) = 2
			end
			utilities.print_test_passed ("occurences")
		end

	test_iteration_index_set
			-- Tests the INDEX_SET feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
			result_index_set: INTEGER_INTERVAL
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.put (default_value, 2 * default_key)
			result_index_set := table.iteration_index_set
			check
				result_index_set.lower = 0
				result_index_set.upper = 1
			end
			utilities.print_test_passed ("iteration_index_set")
		end

	test_same_keys_true
			-- Tests the same_keys feature for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				table.same_keys (default_key, default_key)
			end
			utilities.print_test_passed ("same_keys_true")
		end

	test_same_keys_false
			-- Tests the same_keys feature for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.put (default_value, 2 * default_key)
			check
				not table.same_keys (2 * default_key, default_key)
			end
			utilities.print_test_passed ("same_keys_false")
		end

	test_is_equal_true
			-- Tests the is_equal feature of HASH_TABLE for true case
		local
			table_1: HASH_TABLE [INTEGER, INTEGER]
			table_2: HASH_TABLE [INTEGER, INTEGER]
		do
			create table_1.make (default_size)
			create table_2.make (default_size)
			table_1.put (default_value, default_key)
			table_2.put (default_value, default_key)
			check
				table_1.is_equal (table_2)
			end
			utilities.print_test_passed ("is_equal_true")
		end

	test_is_equal_false
			-- Tests the is_equal feature of HASH_TABLE for false case
		local
			table_1: HASH_TABLE [INTEGER, INTEGER]
			table_2: HASH_TABLE [INTEGER, INTEGER]
		do
			create table_1.make (default_size)
			create table_2.make (default_size)
			table_1.put (default_value, default_key)
			table_2.put (default_value, 2 * default_key)
			check
				not table_1.is_equal (table_2)
			end
			utilities.print_test_passed ("is_equal_false")
		end

	test_disjoint_true
			-- Tests the disjoint feature of HASH_TABLE for true case
		local
			table_1: HASH_TABLE [INTEGER, INTEGER]
			table_2: HASH_TABLE [INTEGER, INTEGER]
		do
			create table_1.make (default_size)
			create table_2.make (default_size)
			table_1.put (default_value, default_key)
			table_2.put (default_value, 2 * default_key)
			check
				table_1.disjoint (table_2)
				not table_1.disjoint (table_1)
			end
			utilities.print_test_passed ("disjoint_true")
		end

	test_disjoint_false
			-- Tests the disjoint feature of HASH_TABLE for false case
		local
			table_1: HASH_TABLE [INTEGER, INTEGER]
			table_2: HASH_TABLE [INTEGER, INTEGER]
		do
			create table_1.make (default_size)
			create table_2.make (default_size)
			table_1.put (default_value, default_key)
			table_2.put (2 * default_value, default_key)
			check
				not table_1.disjoint (table_2)
				not table_1.disjoint (table_1)
			end
			utilities.print_test_passed ("disjoint_false")
		end

	test_full
			-- Tests the full feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			check
				not table.full
			end
			utilities.print_test_passed ("full")
		end

	test_extendible
			-- Tests the extendible feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			check
				not table.extendible
			end
			utilities.print_test_passed ("extendible")
		end

	test_prunable
			-- Tests the prunable feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			check
				table.prunable
			end
			utilities.print_test_passed ("prunable")
		end

	test_inserted_true
			-- Tests the inserted feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				table.inserted
			end
			utilities.print_test_passed ("inserted_true")
		end

	test_inserted_false
			-- Tests the inserted feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.remove (default_key)
			check
				not table.inserted
			end
			utilities.print_test_passed ("inserted_false")
		end

	test_replaced_true
			-- Tests the replace feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.replace (2 * default_value, default_key)
			check
				table.replaced
			end
			utilities.print_test_passed ("replaced_true")
		end

	test_replaced_false
			-- Tests the replace feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				not table.replaced
			end
			utilities.print_test_passed ("replaced_false")
		end

	test_removed_true
			-- Tests the remove feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.remove (default_key)
			check
				table.removed
			end
			utilities.print_test_passed ("removed_true")
		end

	test_removed_false
			-- Tests the remove feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				not table.removed
			end
			utilities.print_test_passed ("removed_false")
		end

	test_found_true
			-- Tests the found feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search (default_key)
			check
				table.found
			end
			utilities.print_test_passed ("found_true")
		end

	test_found_false
			-- Tests the found feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search (2 * default_key)
			check
				not table.found
			end
			utilities.print_test_passed ("found_false")
		end

	test_not_found_true
			-- Tests the not_found feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search (2 * default_key)
			check
				table.not_found
			end
			utilities.print_test_passed ("not_found_true")
		end

	test_not_found_false
			-- Tests the not_found feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search (default_key)
			check
				not table.not_found
			end
			utilities.print_test_passed ("not_found_false")
		end

	test_off_true
			-- Tests the off feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			table.forth
			check
				table.off
			end
			utilities.print_test_passed ("off_true")
		end

	test_off_false
			-- Tests the off feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			check
				not table.off
			end
			utilities.print_test_passed ("off_false")
		end

	test_valid_key_true
			-- Tests the valid key feature of HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				table.valid_key (default_key)
			end
			utilities.print_test_passed ("valid_key_true")
		end

	test_valid_key_false
			-- Tests the valid key feature of HASH_TABLE for false case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			check
				table.valid_key (default_key)
			end
			utilities.print_test_passed ("valid_key_true")
		end

	test_valid_iteration_index_true
			-- Tests the valid_itereation_index for HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			check
				table.valid_iteration_index (0)
			end
			utilities.print_test_passed ("valid_iteration_index_true")
		end

	test_valid_iteration_index_false
			-- Tests the valid_itereation_index for HASH_TABLE for true case
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			check
				not table.valid_iteration_index (10)
			end
			utilities.print_test_passed ("valid_iteration_index_false")
		end

	test_start
		-- Tests the start feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			utilities.print_test_passed ("test_start")
		end

	test_forth
		-- Tests the forth feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.start
			table.forth
			utilities.print_test_passed ("test_forth")
		end

	test_search_found
		-- Tests the found feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search(default_key)
			check
				table.found
				table.found_item = default_value
			end
			utilities.print_test_passed ("test_search_found")
		end

	test_search_not_found
		-- Tests the found feature of HASH_TABLE
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (default_size)
			table.put (default_value, default_key)
			table.search(2 * default_key)
			check
				table.not_found
			end
			utilities.print_test_passed ("test_search_not_found")
		end



end
