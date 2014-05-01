note
	description: "Tests for ARRAYED_QUEUE data structures"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_QUEUE_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
	do
		create utilities
		utilities.print_header ("ARRAYED_QUEUE")

		-- Initialization Tests
		test_make
	end


feature
	 -- All attributes used during testing go here

	 default_size: INTEGER
	 once
	 	Result := 10
	 end

	 default_value: INTEGER
		once
			Result := 37
		end

	 utilities: UTILITIES

feature
	-- Tests for features

	test_make
		-- Tests the make feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			check
				queue /= Void
				queue.is_empty
			end
			utilities.print_test_passed ("make")
		end

end
