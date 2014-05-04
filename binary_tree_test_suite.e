note
	description: "Tests for BINARY_TREE data structure"
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_TREE_TEST_SUITE

create
	run_all_tests

feature

	run_all_tests
		do
			create utilities
			utilities.print_header ("BINARY_TREE")

			-- Creation Procedure Tests
			test_make

			-- Access Tests
			test_parent_none
			test_parent_exists
		end

feature
	-- All attributes used during testing go here

	utilities: UTILITIES

	default_root: INTEGER
	once
		Result := 37
	end

feature
	-- Tests go here

	test_make
		-- Tests make creation procedure of BINARY_TREE
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				has_no_children: tree.arity = 0
				tree_isnt_empty: not tree.is_empty
				root_element: tree.is_root
			end
			utilities.print_test_passed("make")
		end

	test_parent_none
		-- Tests parent feature of a BINARY_TREE without any parent
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				has_no_parent: tree.parent = Void
			end
			utilities.print_test_passed ("parent_none")
		end

	test_parent_exists
		-- Tests parent feature of a BINARY_TREE with a parent
		local
			tree: BINARY_TREE [INTEGER]
			tree_child: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_child.make (2 * default_root)
			tree.put_child (tree_child)
			check
				tree.parent = tree
			end
			utilities.print_test_passed ("parent_exists")
		end
end
