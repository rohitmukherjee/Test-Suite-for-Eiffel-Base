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

				-- Status Report Tests
			test_prunable
			test_valid_cursor_true_case
			test_valid_cursor_false_case
			test_valid_index_true_case
			test_valid_index_false_case
			test_is_inserted_true_case
			test_is_inserted_false_case -- POSSIBLE BUG
			test_all_default_true_case
			test_all_default_false_case

				-- Cursor Movement Tests
--			TODO, not sure how to check cursor movement

				-- Element change Tests
			test_put_front
			test_put_i_th
			test_force
			test_put_left
			test_put_right
			test_merge_left
			test_merge_right
			test_append

				-- Resizing Tests
			test_grow
			test_resize
			test_trim
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

	test_prunable
			-- Tests prunable feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			check
				list.prunable
			end
			utilities.print_test_passed ("prunable")
		end

	test_valid_cursor_true_case
			-- Tests the valid_cursor feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
			cursor: CURSOR
		do
			create list.make_filled (default_size)
		end

	test_valid_cursor_false_case
			-- Tests the valid_cursor feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
			cursor: CURSOR
		do
			create list.make_filled (default_size)
		end

	test_valid_index_true_case
			-- Tests the valid_index feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			check
				list.valid_index (10)
			end
			utilities.print_test_passed ("valid_index_true_case")
		end

	test_valid_index_false_case
			-- Tests the valid_index feature of ARRAYED_LIST for false case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			check
				not list.valid_index (10)
			end
			utilities.print_test_passed ("valid_index_false_case")
		end

	test_is_inserted_true_case
			-- Tests the is_inserted feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_right (2 * default_value)
			check
				list.is_inserted (2 * default_value)
			end
			utilities.print_test_passed ("is_inserted_true_case")
		end

	test_is_inserted_false_case
			-- Tests the is_inserted feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_right (2 * default_value)
			check
				--				not list.is_inserted (default_value)
			end
			utilities.print_test_passed ("is_inserted_false_case")
		end

	test_all_default_true_case
			-- Tests the all_default feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			check
				list.all_default
			end
			utilities.print_test_passed ("all_default_true_case")
		end

	test_all_default_false_case
			-- Tests the all_default feature of ARRAYED_LIST for true case
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make_filled (default_size)
			list.put_front (default_value)
			check
				not list.all_default
			end
			utilities.print_test_passed ("all_default_false_case")
		end

	test_put_front
			-- Tests the put_front feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			check
				size_is_correct: list.count = 1
				element_is_correct: list @ 1 = default_value
			end
			utilities.print_test_passed ("put_front")
		end

	test_put_i_th
			-- Tests the put_ith feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_front (default_value)
			list.put_i_th (2 * default_value, 2)
			check
				size_is_correct: list.count = 2
				capacity_is_correct: list.capacity = default_size
				element_is_correct: list @ 2 = 2 * default_value
			end
			utilities.print_test_passed ("put_i_th")
		end

	test_force
			-- Tests the force/extend feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (2)
			list.put_front (default_value)
			list.put_front (default_value)
			list.force (2 * default_value)
			check
				size_is_correct: list.count = 3
				element_is_correct: list @ 3 = 2 * default_value
			end
			utilities.print_test_passed ("force")
		end

	test_put_left
			-- Tests put_left feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.put_left (2 * default_value)
			check
				size_is_correct: list.count = 2
				element_is_correct: list @ 1 = 2 * default_value
			end
			utilities.print_test_passed ("put_left")
		end

	test_put_right
			-- Tests put_right feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_right (default_value)
			check
				size_is_correct: list.count = 1
				element_is_correct: list @ 1 = default_value
			end
			utilities.print_test_passed ("put_right")
		end

	test_merge_left
			-- Tests merge_left feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
			list_to_copy: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			create list_to_copy.make_filled (default_size)
			list.put_front (default_value)
			list_to_copy.put_front (default_value)
			list.merge_left (list_to_copy)
			check
				list.count = default_size + 2
				list @ 12 = default_value
				list @ 3 = 0
			end
			utilities.print_test_passed ("merge_left")
		end

	test_merge_right
			-- Tests merge_left feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
			list_to_copy: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			create list_to_copy.make_filled (default_size)
			list.put_front (default_value)
			list_to_copy.put_front (default_value)
			list.merge_right (list_to_copy)
			check
				list.count = default_size + 2
				list @ 1 = default_value
				list @ 3 = 0
			end
			utilities.print_test_passed ("merge_left")
		end

	test_append
			-- Tests merge_left feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
			list_to_copy: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			create list_to_copy.make_filled (default_size)
			list.put_front (default_value)
			list_to_copy.put_front (default_value)
			list.append (list_to_copy)
			check
				list.count = default_size + 2
				list @ 1 = default_value
				list @ 3 = 0
			end
			utilities.print_test_passed ("append")
		end

	test_grow
		-- Tests grow feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (1)
			list.grow (10)
			check
				list.count = 0
				list.capacity = 10
			end
			utilities.print_test_passed ("grow")
		end

	test_resize
		-- Tests resize feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (1)
			list.resize (10)
			check
				list.count = 0
				list.capacity = 10
			end
			utilities.print_test_passed ("resize")
		end


	test_trim
		-- Tests trim feature of ARRAYED_LIST
		local
			list: ARRAYED_LIST [INTEGER]
		do
			create list.make (default_size)
			list.put_front (default_value)
			list.trim
			check
				list.capacity = list.count
			end
			utilities.print_test_passed ("trim")
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
