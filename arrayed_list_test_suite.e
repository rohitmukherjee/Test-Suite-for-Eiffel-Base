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
		end

feature
	-- All attributes used during testing go here

	utilities: UTILITIES

end
