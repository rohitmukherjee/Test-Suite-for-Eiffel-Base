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
			test_make_2

				-- Access Tests
			test_parent_none
			test_parent_exists
			test_child_index_1
			test_child_index_2
			test_left_child_none
			test_left_child_exists
			test_right_child_none
			test_right_child_exists
			test_left_item_none
			test_left_item_exists
			test_right_item_none
			test_right_item_exists
			test_first_child_none
			test_first_child_exists
			test_second_child_none
			test_second_child_exists
			test_child_1
			test_left_sibling_none
			test_left_sibling_exists
			test_right_sibling_none
			test_right_sibling_exists
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
			utilities.print_test_passed ("make")
		end

	test_make_2
			-- Tests to expose bug where new node can be added with make but not at root position
		local
			tree_1: BINARY_TREE [INTEGER]
			tree_2: BINARY_TREE [INTEGER]
		do
			create tree_1.make (default_root)
			create tree_2.make (default_root)
			tree_1.put_left_child (tree_2)
			tree_2.make (default_root * 2)
			check
				tree_2.parent = default_root * 2
				tree_1.left_child = default_root * 2
			end
			utilities.print_test_passed ("make_2")
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

	test_child_index_1
			-- Tests the child_index feature of BINARY_TREE
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_left.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			check
				tree.child_index = 1
			end
			utilities.print_test_passed ("child_index_1")
		end

	test_child_index_2
			-- Tests the child_index feature of BINARY_TREE
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			tree_right.make (4 * default_root)
			check
				tree.child_index = 1
			end
			utilities.print_test_passed ("child_index_2")
		end

	test_left_child_none
			-- Tests left_child feature of BINARY_TREE for no left child
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.left_child = Void
			end
			utilities.print_test_passed ("left_child_none")
		end

	test_left_child_exists
			-- Tests left_child feature of BINARY_TREE for left child exists
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.left_child = tree_left
			end
			utilities.print_test_passed ("left_child_exists")
		end

	test_right_child_none
			-- Tests left_child feature of BINARY_TREE for no left child
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.right_child = Void
			end
			utilities.print_test_passed ("right_child_none")
		end

	test_right_child_exists
			-- Tests left_child feature of BINARY_TREE for left child exists
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.right_child = tree_right
			end
			utilities.print_test_passed ("right_child_exists")
		end

	test_left_item_none
			-- Tests the left_item feature of BINARY_TREE for no left_child
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.left_item = Void
			end
			utilities.print_test_passed ("left_item_none")
		end

	test_left_item_exists
			-- Tests the left_item feature of BINARY_TREE for left_child
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.left_item = 2 * default_root
			end
			utilities.print_test_passed ("left_item_exists")
		end

	test_right_item_none
			-- Tests the right_item feature of BINARY_TREE for no right child
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.right_item = Void
			end
			utilities.print_test_passed ("right_item_none")
		end

	test_right_item_exists
			-- Tests the right_item feature of BINARY_TREE for right child
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_left_child (tree_right)
			check
				tree.right_item = 2 * default_root
			end
			utilities.print_test_passed ("right_item_exists")
		end

	test_first_child_none
			-- Tests first_child feature for no first_child
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.first_child = Void
			end
			utilities.print_test_passed ("first_child_none")
		end

	test_first_child_exists
			-- Tests first_child feature for first child
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.first_child = tree_left
			end
			utilities.print_test_passed ("first_child_exists")
		end

	test_second_child_none
			-- Tests first_child feature for no first_child
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.last_child = Void
			end
			utilities.print_test_passed ("second_child_none")
		end

	test_second_child_exists
			-- Tests first_child feature for no first_child
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.last_child = Void
			end
			utilities.print_test_passed ("second_child_exists")
		end

	test_child_1
			-- Tests the child feature of BINARY_TREE
		local
			tree, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.child = tree.parent -- POSSIBLE BUG. Think this should fail
				tree.child = tree.right_child
			end
			utilities.print_test_passed ("child_1")
		end

	test_left_sibling_exists
			-- Tests the left_sibling feature of BINARY_TREE for left_sibling
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			check
				tree_right.left_sibling = tree_left
			end
			utilities.print_test_passed ("right_sibling_exists")
		end

	test_left_sibling_none
			-- Tests the left_sibling feature of BINARY_TREE for no left_sibling
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.left_sibling = Void
			end
			utilities.print_test_passed ("left_sibling_none")
		end

	test_right_sibling_none
			-- Tests the right_sibling feature of BINARY_TREE for no right_sibling
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.right_sibling = Void
			end
			utilities.print_test_passed ("right_sibling_none")
		end

	test_right_sibling_exists
			-- Tests the right_sibling feature of BINARY_TREE for  right_sibling
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			check
				tree_left.right_sibling = tree_right
			end
			utilities.print_test_passed ("right_sibling_exists")
		end

end
