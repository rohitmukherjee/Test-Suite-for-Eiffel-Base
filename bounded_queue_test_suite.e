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

end
