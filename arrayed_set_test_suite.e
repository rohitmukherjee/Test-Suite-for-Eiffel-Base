note
	description: "Tests for ARRAYED_SET data structure"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_SET_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("ARRAYED_SET")

			-- Element Change Tests
			test_put

			-- Removal Tests
			test_prune
			test_prune_all -- POSSIBLE INSUFFICIENT SPECIFICATION
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

	test_put
		-- Tests the put/extend feature of ARRAYED_SET
		-- by trying to place a duplicate element into the set
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (default_size)
			set.put (default_value)
			set.put (default_value)
			set.put (2 * default_value)
			check
				default_value_shouldnt_be_added_twice: set.count = 2
			end
			utilities.print_test_passed ("put/extend")
		end

	test_prune
		-- Tests prune feature of ARRAYED_SET by removing an item and re - inserting
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (default_size)
			set.put (default_value)
			set.put (2 * default_value)
			set.prune(default_value)
			check
				size_is_correct: set.count = 1
				cursor_should_have_been_moved: set.item  = 2 * default_value
			end
			utilities.print_test_passed ("prune")
		end

	test_prune_all
		-- Tests prune_all feature of ARRAYED_SET (inherited from ARRAYED_LIST)
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (default_size)
			set.put (default_value)
			set.put (2 * default_value)
			set.prune_all(default_value)
			check
				size_is_correct: set.count = 1
--				cursor_should_have_been_moved: set.item  = 2 * default_value --ASSERTION BREAKS because item is not defined
			end
			utilities.print_test_passed ("prune_all")
		end
end
