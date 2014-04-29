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
			test_has_true_case
			test_has_false_case
			test_to_array -- POSSIBLE BUG

				-- Iteration Tests
			test_do_all
			test_do_if
			test_there_exists_true_case
			test_there_exists_false_case
			test_for_all_true_case
			test_for_all_false_case
			test_do_all_with_index
			test_do_if_with_index

				-- Measurement Tests
			test_lower
			test_upper
			test_count
			test_capacity

				-- Comparison Tests
			test_is_equal_true_case
			test_is_equal_false_case
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

	list_do_all: ARRAYED_LIST [INTEGER]

	list_do_if: ARRAYED_LIST [INTEGER]

	list_do_all_with_index: ARRAYED_LIST [INTEGER]

	list_do_if_with_index: ARRAYED_LIST [INTEGER]

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
				upper_is_correct: list.upper = array.count
				lower_is_correct: list.lower = 1
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

	test_has_true_case
			-- Tests case where arrayed_list has the element
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			list.put_front (3 * default_value)
			check
				list.has (default_value)
				list.has (2 * default_value)
				list.has (3 * default_value)
			end
			utilities.print_test_passed ("has_true_case")
		end

	test_has_false_case
			-- Tests case where arrayed_list doesn't have the element
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			check
				not list.has (3 * default_value)
			end
			utilities.print_test_passed ("has_false_case")
		end

	test_to_array
			-- Tests to_array feature
		local
			list: ARRAYED_LIST [INTEGER]
			array: ARRAY [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			array := list.to_array
			check
				array.count = 2
				list.capacity = default_size
					--				array.capacity = default_size
				array.upper = list.upper
				array.lower = list.lower
			end
			utilities.print_test_passed ("to_array")
		end

	test_do_all
			-- Tests do_all feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_front (default_value)
			create list_do_all.make (default_size)
			list.do_all (agent  (value: INTEGER)
				do
					list_do_all.put_front (2 * value)
				end)
			check
				size_is_correct: list_do_all.count = list.count
				across list_do_all as element all element.item = 2 * default_value end
			end
			utilities.print_test_passed ("do_all")
		end

	test_do_if
			-- Tests do_if feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			create list_do_if.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			list.do_if (agent put_in_list_do_if(?), agent is_even(?))
			check
				size_is_correct: list_do_if.count = 1
				list_do_if @ 1 = 2 * default_value
			end
			utilities.print_test_passed ("do_if")
		end

	test_there_exists_true_case
			-- Tests there_exists feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			check
				list.there_exists (agent is_even(?))
			end
			utilities.print_test_passed ("there_exists_true_case")
		end

	test_there_exists_false_case
			-- Tests there_exists feature of ARRAYED_LIST for false case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			check
				not list.there_exists (agent is_even(?))
			end
			utilities.print_test_passed ("there_exists_false_case")
		end

	test_for_all_true_case
			-- Tests for_all feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (2 * default_value)
			list.put_front (2 * default_value)
			check
				list.for_all (agent is_even(?))
			end
			utilities.print_test_passed ("for_all_true_case")
		end

	test_for_all_false_case
			-- Tests for_all feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			check
				not list.for_all (agent is_even(?))
			end
			utilities.print_test_passed ("for_all_false_case")
		end

	test_do_all_with_index
			-- Tests do_all feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_front (default_value)
			create list_do_all_with_index.make_filled (default_size)
			list.do_all_with_index (agent  (value: INTEGER; index: INTEGER)
				do
					list_do_all_with_index.put_i_th (2 * value, index)
				end)
			check
				list_do_all_with_index @ 1 = 2 * default_value
				list_do_all_with_index @ 1 = 2 * default_value
				list_do_all_with_index @ 3 = 2 * default_value
			end
			utilities.print_test_passed ("do_all_with_index")
		end

	test_do_if_with_index
			-- Tests do_if feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			create list_do_if_with_index.make_filled (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_front (2 * default_value)
			list.do_if_with_index (agent put_in_list_do_if_with_index(?, ?), agent first_is_even(?, ?))
			check
				size_is_correct: list_do_if.count = 1
				list_do_if @ 1 = 2 * default_value
			end
			utilities.print_test_passed ("do_if_with_index")
		end

	test_lower
			-- Tests lower feature of ARRAYED_LIST
			local
				list: ARRAYED_LIST [INTEGER]
			do
				create list.make (default_size)
				list.put_front (default_value)
				list.put_front (default_value)
				check
					list.lower = 1
				end
				utilities.print_test_passed ("lower")
			end

	test_upper
			-- Tests upper feature of ARRAYED_LIST
			local
				list: ARRAYED_LIST [INTEGER]
			do
				create list.make (default_size)
				list.put_front (default_value)
				list.put_front (default_value)
				check
					list.upper = 2
					list.upper = list.count
				end
				utilities.print_test_passed ("upper")
			end

	test_count
		-- Tests count feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			check
				list.count = 1
				list.count = list.upper
				list.count = list.lower
			end
			utilities.print_test_passed ("count")
		end

	test_capacity
		-- Tests count feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			check
				list.capacity = default_size
			end
			utilities.print_test_passed ("capacity")
		end

	test_is_equal_true_case
		-- Tests true case of is_equal feature of ARRAYED_LIST
		local
			list1: ARRAYED_LIST [INTEGER]
			list2: ARRAYED_LIST [INTEGER]
		do
			create list1.make (default_size)
			create list2.make (default_size)
			list1.put_front (default_value)
			list2.put_front (default_value)
			check
				list1.is_equal (list1)
				list2.is_equal (list2)
				list1.is_equal (list2)
				list2.is_equal (list1)
			end
			utilities.print_test_passed ("is_equal_true_case")
		end

		test_is_equal_false_case
		-- Tests true case of is_equal feature of ARRAYED_LIST
		local
			list1: ARRAYED_LIST [INTEGER]
			list2: ARRAYED_LIST [INTEGER]
		do
			create list1.make (default_size)
			create list2.make (default_size)
			list1.put_front (default_value)
			list2.put_front (2 * default_value)
			check
				not list1.is_equal (list2)
				not list2.is_equal (list1)
			end
			utilities.print_test_passed ("is_equal_false_case")
		end


feature
	-- All helper features go here

	is_even (a_value: INTEGER): BOOLEAN
		do
			Result := a_value \\ 2 = 0
		end

	first_is_even (a_value: INTEGER; a_index: INTEGER): BOOLEAN
		do
			Result := a_value \\ 2 = 0 and a_index = 1
		end

	put_in_list_do_if (a_value: INTEGER)
		do
			list_do_if.put_front (a_value)
		end

	put_in_list_do_if_with_index (a_value: INTEGER; a_index: INTEGER)
		do
			list_do_if_with_index.put_i_th (a_value, a_index)
		end

end
