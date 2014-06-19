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

end
