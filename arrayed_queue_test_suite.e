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

		-- Comparison Tests
		test_is_equal_true
		test_is_equal_false

		-- Measurement Tests
		test_count
		test_capacity
		test_occurences
		test_index_set

		-- Status Report Tests
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

	test_is_equal_true
		-- Tests is_equal feature of ARRAYED_QUEUE for true case
		local
			queue: ARRAYED_QUEUE [INTEGER]
			queue2: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			create queue2.make (default_size)
			queue.put (default_value)
			queue.put (4 * default_value)
			queue2.put (default_value)
			queue2.put (4 * default_value)
			check
				queue.is_equal(queue)
				queue.is_equal(queue2)
				queue2.is_equal (queue)
			end
			utilities.print_test_passed ("is_equal_true_case")
		end

		test_is_equal_false
		-- Tests is_equal feature of ARRAYED_QUEUE for false case
		local
			queue: ARRAYED_QUEUE [INTEGER]
			queue2: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			create queue2.make (default_size)
			queue.put (4 * default_value)
			queue2.put (default_value)
			queue2.put (4 * default_value)
			check
				not queue.is_equal(queue2)
			end
			utilities.print_test_passed ("is_equal_false_case")
		end

		test_count
			-- Tests count feature of ARRAYED_QUEUE
			local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (4 * default_value)
			queue.put (default_value)
			queue.remove
			check
				queue.count = 1
			end
			utilities.print_test_passed ("count")
		end

		test_capacity
			-- Tests count feature of ARRAYED_QUEUE
			local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (4 * default_value)
			queue.put (default_value)
			queue.remove
			check
				queue.capacity = default_size
			end
			utilities.print_test_passed ("capacity")
		end

		test_occurences
			-- Tests occurences feature of ARRAYED_QUEUE
			local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (4 * default_value)
			queue.put (default_value)
			queue.put (default_value)
			queue.put (default_value)
			queue.put (default_value)
			check
				queue.occurrences (default_value) = 4
				queue.occurrences (3 * default_value) = 0
				queue.occurrences (4 * default_value) = 1
			end
			utilities.print_test_passed ("occurences")
		end


		test_index_set
			-- Tests index_set feature of ARRAYED_QUEUE
			local
			queue: ARRAYED_QUEUE [INTEGER]
			interval: INTEGER_INTERVAL
		do
			create queue.make (default_size)
			queue.put (4 * default_value)
			queue.put (default_value)
			queue.put (default_value)
			queue.put (default_value)
			queue.put (default_value)
			interval := queue.index_set
			check
				index_set_returned_within_bounds: interval.lower = 1 and interval.upper = 5
			end
			utilities.print_test_passed ("index_set")
		end
end
