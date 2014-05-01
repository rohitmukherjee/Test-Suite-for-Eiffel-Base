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
			test_is_empty_true_case
			test_is_empty_false_case
			test_extendible
			test_prunable

				-- Element Change Tests
			test_put -- Also tests force, extend as they are aliases
			test_replace

				-- Removal Tests
			test_remove
			test_wipe_out

				-- Resizing Tests
			test_trim

				-- Conversion Tests
			test_linear_representation

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
				queue.is_equal (queue)
				queue.is_equal (queue2)
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
				not queue.is_equal (queue2)
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

	test_is_empty_true_case
			-- Tests is_empty feature of ARRAYED_QUEUE for true case
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.remove
			check
				still_empty: queue.is_empty
			end
			utilities.print_test_passed ("is_empty_true_case")
		end

	test_is_empty_false_case
			-- Tests is_empty feature of ARRAYED_QUEUE for false case
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			check
				not queue.is_empty
			end
			utilities.print_test_passed ("is_empty_false_case")
		end

	test_extendible
			-- Tests extendible feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			check
				queue.extendible
			end
			utilities.print_test_passed ("extendible")
		end

	test_prunable
			-- Tests extendible feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			check
				not queue.prunable
			end
			utilities.print_test_passed ("prunable")
		end

	test_put
			-- Tests put/extend/force feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
			i: INTEGER
		do
			create queue.make (100)
			from
				i := 1
			until
				i = 101
			loop
				queue.put (default_value)
				i := i + 1
			end
			check
				queue.count = 100
				queue.item = default_value
			end
			utilities.print_test_passed ("put/extend/force")
		end

	test_replace
		-- Tests the replace feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (2 * default_value)
			queue.replace (3 * default_value)
			check
				queue.item = 3 * default_value
				queue.count = 2
			end
			utilities.print_test_passed ("replace")
		end

	test_remove
		-- Tests remove feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (3 * default_value)
			queue.put (2 * default_value)
			queue.put (default_value)
			queue.remove
			queue.remove
			check
				queue.count = 1
				queue.item = default_value
			end
			utilities.print_test_passed ("remove")
		end

	test_wipe_out
		-- Tests the wipe_out feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (3 * default_value)
			queue.put (2 * default_value)
			queue.put (default_value)
			queue.wipe_out
			check
				queue.count = 0
			end
			utilities.print_test_passed ("wipe_out")
		end

	test_trim
		-- Tests the trim feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (default_value)
			queue.put (default_value)
			queue.trim
			check
				capacity_is_trimmed: queue.capacity = queue.count
			end
			utilities.print_test_passed ("trim")
		end

	test_linear_representation
		-- Tests the linear_representation feature of ARRAYED_QUEUE
		local
			queue: ARRAYED_QUEUE [INTEGER]
			list: ARRAYED_LIST [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			queue.put (2 * default_value)
			queue.put (3 * default_value)
			list := queue.linear_representation
			check
				list @ 1 = default_value
				list @ 2 = 2 * default_value
				list @ 3 = 3 * default_value
				list.count = 3
				list.upper = list.count
				list.lower = 1
			end
				utilities.print_test_passed ("linear_representation")
		end
end
