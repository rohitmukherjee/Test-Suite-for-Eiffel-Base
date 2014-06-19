note
	description: "Tests for BOUNDED_QUEUE data structure"
	date: "$Date$"
	revision: "$Revision$"

class
	BOUNDED_QUEUE_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("BOUNDED_QUEUE")

				-- Creation Tests
			test_make

				-- Status report Tests
			test_extendible_true
			test_extendible_false

				-- Comparison Tests
			test_equal_1
			test_equal_2
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
			-- Tests the make feature of BOUNDED_QUEUE
		local
			queue: BOUNDED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			check
				queue /= Void
				not queue.is_empty
			end
			utilities.print_test_passed ("make")
		end

	test_extendible_true
			-- Tests the extendible feature of BOUNDED_QUEUE for true case
		local
			queue: BOUNDED_QUEUE [INTEGER]
		do
			create queue.make (default_size)
			queue.put (default_value)
			check
				queue.extendible = true
			end
			utilities.print_test_passed ("extendible_true")
		end

	test_extendible_false
			-- Tests the extendible feature of BOUNDED_QUEUE for false case
		local
			queue: BOUNDED_QUEUE [INTEGER]
		do
			create queue.make (2)
			queue.put (default_value)
			queue.put (default_value)
			check
				not queue.extendible
			end
			utilities.print_test_passed ("extendible_false")
		end

	test_equal_1
			-- Tests the equal feature of BOUNDED_QUEUE
		local
			queue_1: BOUNDED_QUEUE [INTEGER]
			queue_2: BOUNDED_QUEUE [INTEGER]
		do
			create queue_1.make (2)
			queue_1.put (1)
			queue_1.put (2)
			queue_1.remove
			queue_1.put (3)
			create queue_2.make (2)
			queue_2.put (1)
			queue_2.put (2)
			queue_2.remove
			queue_2.put (3)
			check
				queue_1.is_equal (queue_2)
			end
			utilities.print_test_passed ("test_equal_1")
		end

	test_equal_2
			-- Tests the equal feature of BOUNDED_QUEUE
		local
			queue1: BOUNDED_QUEUE [INTEGER]
			queue2: BOUNDED_QUEUE [INTEGER]
		do
			create queue1.make (2)
			queue1.compare_objects
			queue1.put (1)
			queue1.put (2)
			queue1.remove
			queue1.put (3)
			create queue2.make (2)
			queue2.compare_objects
			queue2.put (1)
			queue2.put (2)
			queue2.remove
			queue2.put (3)
			check
				queue1.is_equal (queue2)
			end
			utilities.print_test_passed ("test_equal_2")
		end

end
