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
		do
			create array_test_suite.run_all_tests
		end
end


