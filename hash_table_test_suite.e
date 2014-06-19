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
			test_accomodate
			test_has_false
			test_has_true
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
			print( table.has (3000) = True)
			check
				should_be_true: table.has (2 * default_key) = False -- This equality should break
			end
			utilities.print_test_passed ("has_true")
		end

end
