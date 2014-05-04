note
	description : "Root Test Suite Class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_SUITE

create
	make

feature -- Root Test Class.

	make
			-- Run application.
		local
			array_test_suite: ARRAY_TEST_SUITE
			arrayed_list_test_suite: ARRAYED_LIST_TEST_SUITE
			arrayed_queue_test_suite: ARRAYED_QUEUE_TEST_SUITE
			arrayed_set_test_suite: ARRAYED_SET_TEST_SUITE
		do
--			create arrayed_queue_test_suite.run_all_tests
--			create arrayed_list_test_suite.run_all_tests
--			create array_test_suite.run_all_tests
			create arrayed_set_test_suite.run_all_tests
		end
end


