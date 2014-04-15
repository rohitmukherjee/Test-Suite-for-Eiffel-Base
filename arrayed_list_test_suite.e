note
	description: "Tests for ARRAYED_LIST data structure"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_LIST_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("Arrayed_list")

				-- Creation procedure tests
			test_make
			test_make_filled
			test_make_from_array

				-- Access Feature Tests
			test_area
			test_item
			test_first
			test_last
			test_index
			test_cursor
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
	-- Tests

	test_make
			-- Tests make creation procedure
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			check
				list_should_be_empty: list.is_empty
				count_should_be_zero: list.count = 0
				size_is_correct: list.capacity = default_size
				across list as element all element.item = 0 end
			end
			utilities.print_test_passed ("make")
		end

	test_make_filled
			-- Tests make_filled creation procedure
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			check
				not_empty: not list.is_empty
				count_should_be_default_size: list.count = default_size
				size_is_correct: list.capacity = default_size
				across list as element all element.item = 0 end
			end
			utilities.print_test_passed ("make_filled")
		end

	test_make_from_array
			-- Tests make_from_array creation procedure
		local
			list: ARRAYED_LIST [INTEGER]
			array: ARRAY [INTEGER]
		do
			create array.make_filled (default_value, 0, 99)
			create list.make_from_array (array)
			check
				size_is_correct: list.count = array.count
				across list as element all element.item = default_value end
			end
			utilities.print_test_passed ("make_from_array")
		end

	test_area
			-- Tests area access feature
		local
			list: ARRAYED_LIST [INTEGER]
			special: SPECIAL [INTEGER]
		do
			create list.make_filled (default_size)
			special := list.area
			check
				size_is_correct: special.count = default_size
				across special as element all element.item = 0 end
			end
			utilities.print_test_passed ("area")
		end

	test_item
			-- Tests item access feature
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			check
				list.item = default_value
			end
			utilities.print_test_passed ("item")
		end

	test_first
			-- Tests item access feature
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_right (2 * default_value)
			check
				list.first = default_value
			end
			utilities.print_test_passed ("first")
		end

	test_last
			-- Tests item access feature
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_left (default_value)
			list.put_right (2 * default_value)
			list.put_right (default_value)
			check
				list.last = 2 * default_value
			end
			utilities.print_test_passed ("last")
		end

	test_index
			-- Tests index of current item
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			list.put_front (default_value)
			list.put_right (default_value)
			check
				list.index = 1
			end
			utilities.print_test_passed ("index")
		end

	test_cursor
			-- Tests cursor position
		local
			list: ARRAYED_LIST [INTEGER]
			cursor: ARRAYED_LIST_CURSOR
		do
			create list.make_filled (default_size)
			list.put_front (default_value)
			list.put_right (default_value)
			cursor := list.cursor
			utilities.print_test_passed ("cursor")
		end
end
