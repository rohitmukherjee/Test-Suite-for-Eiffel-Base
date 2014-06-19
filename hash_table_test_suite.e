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

		end

feature
	-- All attributes used during testing go here

	utilities: UTILITIES

	default_size: INTEGER
		once
			Result := 10
		end

	default_value: INTEGER
		once
			Result := 37
		end

feature
	-- Tests go here

test_make
	-- Tests make feature of HASH_TABLE
	local
		table: HASH_TABLE[INTEGER, INTEGER]
	do
		create table.make (default_size)
		check
			table /= Void
		end
		utilities.print_test_passed ("make")
	end
end
