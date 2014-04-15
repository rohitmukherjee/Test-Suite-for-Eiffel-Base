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

end
