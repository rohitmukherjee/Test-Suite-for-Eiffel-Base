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

		-- Access Tests
		test_item
		test_has_true_case
		test_has_false_case
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

	test_item
		-- Tests the item feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (2 * default_value)
			check
				queue.item = default_value
			end
			utilities.print_test_passed ("item")
		end

	test_has_true_case
		-- Tests the has feature of ARRAYED_QUEUE for true case
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (2 * default_value)
			check
				queue.has (default_value)
			end
			utilities.print_test_passed ("has_true_case")
		end

	test_has_false_case
		-- Tests the has feature of ARRAYED_QUEUE for true case
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (4 * default_value)
			check
				not queue.has (2 * default_value)
			end
			utilities.print_test_passed ("has_false_case")
		end
end
