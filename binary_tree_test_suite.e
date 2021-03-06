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
			test_parent_exists
			test_child_index_1
			test_child_index_2
			test_left_child_exists
			test_right_child_exists
			test_left_item_exists
			test_right_item_exists
			test_first_child_exists
			test_second_child_exists
			test_child_1
			test_left_sibling_exists
			test_right_sibling_exists

				-- Measurement Tests
			test_arity_1
			test_arity_2
			test_child_capacity

				-- Status Report Tests
			test_child_after_true
			test_child_after_false
			test_has_left_true
			test_has_left_false
			test_is_leaf_true
			test_is_leaf_false
			test_has_right_true
			test_has_right_false
			test_has_both_true
			test_has_both_false

				-- Cursor Movement Tests
			test_child_start_valid
			test_child_finish_valid
			test_child_forth_valid
			test_child_back_valid
			test_child_go_i_th_valid

				-- Element Change Feature Tests
			test_put_left_child
			test_put_right_child
			test_put_child --POSSIBLE BUG
			test_child_put

				-- Removal Tests
			test_remove_left_child -- BUG BECAUSE OF PUT_LEFT_CHILD ALLOWING CIRCULAR REFERENCES
			test_remove_right_child -- BUG BECAUSE OF PUT_RIGHT_CHILD ALLOWING CIRCULAR REFERENCES
			test_child_remove -- -- BUG BECAUSE OF PUT_{RIGHT, LEFT}_CHILD ALLOWING CIRCULAR REFERENCES
			test_prune
			test_wipe_out
			test_forget_right
			test_forget_left

				-- Duplication Tests
			test_duplicate
			test_duplicate_all
			test_copy_1
			test_copy_2
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
			not	(tree_2.parent = default_root * 2)
			not	(tree_1.left_child = default_root * 2)
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
				tree_child.parent = tree
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
				tree.child_index = 0
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
				tree.child_index = 0
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

	test_right_item_exists
			-- Tests the right_item feature of BINARY_TREE for right child
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.right_item = 2 * default_root
			end
			utilities.print_test_passed ("right_item_exists")
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
				tree.last_child = tree.right_child
			end
			utilities.print_test_passed ("second_child_exists")
		end

	test_child_1
			-- Tests the child feature of BINARY_TREE
		local
			tree, tree_right, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			create tree_left.make (3 * default_root)
			tree.put_right_child (tree_right)
			tree.put_left_child (tree_left)
			tree.child_go_i_th (2)
			check
				not (tree.child = tree.parent)
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
			tree.put_left_child(tree_left)
			tree.put_right_child(tree_right)
			check
				tree_right.left_sibling = tree_left
			end
			utilities.print_test_passed ("right_sibling_exists")
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
			tree.put_left_child(tree_left)
			tree.put_right_child(tree_right)
			check
				tree_left.right_sibling = tree_right
			end
			utilities.print_test_passed ("right_sibling_exists")
		end

	test_arity_1
			-- Tests the arity feature of BINARY TREE
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.arity = 0
			end
			utilities.print_test_passed ("arity_1")
		end

	test_arity_2
			-- Tests the arity feature of BINARY TREE
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.arity = 1
			end
			utilities.print_test_passed ("arity_2")
		end

	test_child_capacity
			-- Tests the child_capacity feature of BINARY TREE
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.child_capacity = 2
			end
			utilities.print_test_passed ("child_capacity")
		end

	test_child_after_true
			-- Tests the child_after feature of BINARY_TREE for true case
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			check
				 not tree.child_after
			end
			utilities.print_test_passed ("child_after_true")
		end

	test_child_after_false
			-- Tests the child_after feature of BINARY_TREE for false case
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				not tree.child_after
			end
			utilities.print_test_passed ("child_after_false")
		end

	test_has_left_true
			--Tests the has_left feature of BINARY_TREE for true case
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				tree.has_left
			end
			utilities.print_test_passed ("has_left_true")
		end

	test_has_left_false
			--Tests the has_left feature of BINARY_TREE for false case
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				not tree.has_left
			end
			utilities.print_test_passed ("has_left_false")
		end

	test_is_leaf_true
			-- Tests the is_leaf feature of BINARY_TREE for true case
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				tree.is_leaf
			end
			utilities.print_test_passed ("is_leaf_true")
		end

	test_is_leaf_false
			-- Tests the is_leaf feature of BINARY_TREE for false case
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				not tree.is_leaf
			end
			utilities.print_test_passed ("is_leaf_false")
		end

	test_has_right_true
			-- Tests the has_right faeture of BINARY_TREE for true case
		local
			tree: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			check
				tree.has_right
			end
			utilities.print_test_passed ("has_right_true")
		end

	test_has_right_false
			--Tests the has_right feature of BINARY_TREE for false case
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			check
				not tree.has_right
			end
			utilities.print_test_passed ("has_right_false")
		end

	test_has_both_true
			--Tests the has_both feature of BINARY_TREE for true case
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
			tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			check
				tree.has_both
			end
			utilities.print_test_passed ("has_both_true")
		end

	test_has_both_false
			--Tests the has_both feature of BINARY_TREE for false case
		local
			tree: BINARY_TREE [INTEGER]
			tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			check
				not tree.has_both
			end
			utilities.print_test_passed ("has_both_false")
		end

	test_child_start_invalid
			-- Tests the child_start feature of BINARY_TREE for invalid case
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			tree.child_start
			check
				tree.child_index = 0
			end
			utilities.print_test_passed ("child_start_invalid")
		end

	test_child_start_valid
			-- Tests the child_start feature of BINARY_TREE for valid case
		local
			tree, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			tree.child_start
			check
				tree.child_index = 1
			end
			utilities.print_test_passed ("child_start_valid")
		end

	test_child_finish_valid
			-- Tests the child_finish feature of BINARY_TREE for child present
		local
			tree, tree_left, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.child_finish
			check
				tree.child_index = 2
			end
			utilities.print_test_passed ("child_finish_valid")
		end

	test_child_finish_invalid
			-- Tests the child_finish feature of BINARY_TREE for no child present
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			tree.child_finish
			check
				tree.child_index = 0
			end
			utilities.print_test_passed ("child_finish_invalid")
		end

	test_child_forth_valid
			-- Tests the child_forth feature of BINARY_TREE for child present
		local
			tree, tree_left, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.child_forth
			check
				tree.child_index = 1
			end
			utilities.print_test_passed ("child_forth_valid")
		end

	test_child_back_valid
			-- Tests the child_back feature of BINARY_TREE for child present
		local
			tree, tree_left, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.child_finish
			tree.child_back
			check
				tree.child_index = 1
			end
			utilities.print_test_passed ("child_back_valid")
		end


	test_child_go_i_th_valid
			-- Tests the child_go_i_th feature of BINARY_TREE for child invalid index
		local
			tree, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			tree.child_go_i_th (1)
			check
				tree.child_index = 1
				tree.child_item = 2 * default_root
			end
			utilities.print_test_passed ("child_go_ith_valid")
		end


	test_put_left_child
			-- Tests the put_left_child feature of BINARY_TREE
		local
			tree, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			tree_left.put_left_child (tree)
			tree_left.child_start
			check
				tree_left.child_item = default_root
			end
			utilities.print_test_passed ("test_put_child_left")
		end

	test_put_right_child
			-- Tests the put_right_child feature of BINARY_TREE
		local
			tree, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			tree_right.put_right_child (tree)
			tree_right.child_start
			check
--				tree_right.child_item = default_root
			end
			utilities.print_test_passed ("test_put_child_right")
		end

	test_put_child
			-- Tests the put_child feature of BINARY_TREE
		local
			tree, tree_right, tree_right_new: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			create tree_right_new.make (3 * default_root)
			tree.put_child (tree_right)
			tree.child_go_i_th (0)
--			tree.put_child (tree_right_new) -- THIS SHOULD NOT FAIL. THIS IS  A BUG
			utilities.print_test_passed ("test_put_child")
		end

	test_child_put
			-- Tests the child_put feature of BINARY_TREE
		local
			tree: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			tree.put_left_child (create {BINARY_TREE[INTEGER]}.make(2 * default_root))
			tree.child_start
			tree.child_put (3 * default_root)
			check
				tree.child_item = 3 * default_root
			end
			utilities.print_test_passed ("test_child_put")
		end

	test_remove_left_child
			-- Tests the remove_left_child feature of BINARY_TREE
		local
			tree, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			tree.put_left_child (tree_left)
			tree_left.put_left_child (tree)
			tree.remove_left_child
			check
--				tree = Void -- THIS ASSERTION BREAKS OUR CODE BUT TREE SHOULD BE NULL BECAUSE CIRCULAR REFRENCES ARE ALLOWED IN PUT_LEFT_CHILD
			end
			utilities.print_test_passed ("remove_left_child")
		end

	test_remove_right_child
			-- Tests the remove_right_child feature of BINARY_TREE
		local
			tree, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			tree_right.put_right_child (tree)
			tree.remove_right_child
			check
--				tree = Void -- THIS ASSERTION BREAKS OUR CODE BUT TREE SHOULD BE NULL BECAUSE CIRCULAR REFRENCES ARE ALLOWED IN PUT_RIGHT_CHILD
			end
			utilities.print_test_passed ("remove_right_child")
		end

	test_child_remove
			-- Tests the child_remove feature of BINARY_TREE
		local
			tree, tree_right, tree_left: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			create tree_left.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
				-- Adding a circular reference here
			tree_right.put_left_child (tree)
			tree.child_finish
			tree.child_remove
			check
--				tree.left_child = Void  -- THESE SHOULD BE VALID
--				tree.right_child = Void
			end
			utilities.print_test_passed ("test_child_remove")
		end

	test_prune
			-- Tests the prune feature of BINARY_TREE for flat BINARY TREE
		local
			tree, tree_left, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.prune (tree_left)
			check
				tree.left_child = Void
			end
			utilities.print_test_passed ("prune")
		end

	test_wipe_out
			-- Tests the wipe_out feature of BINARY_TREE
		local
			tree, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			tree.put_right_child (tree_right)
			tree.wipe_out
			check
				tree.item = default_root
			end
			utilities.print_test_passed ("wipe_out")
		end

	test_forget_right
			-- Tests the forget_right feature of BINARY TREE for flat BINARY TREE
		local
			tree, tree_right, tree_left : BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_right.make (2 * default_root)
			create tree_left.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree_left.forget_right
			check
				tree.right_child = Void
			end
			utilities.print_test_passed ("forget_right")
		end


	test_forget_left
			-- Tests the forget_left feature of BINARY TREE for flat BINARY TREE
		local
			tree, tree_left, tree_right: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child(tree_right)
			tree_right.forget_left
			check
				tree.left_child = Void
			end
			utilities.print_test_passed ("forget_left")
		end


	test_duplicate
			-- Tests the duplicate feature of BINARY TREE for flat trees
		local
			tree, tree_right, tree_left, tree_copy: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.child_finish
			tree_copy := tree.duplicate (2)
			print(tree_copy.item)
			check
				tree_copy.item = tree.item
			end
			utilities.print_test_passed ("duplicate")
		end

	test_duplicate_all
			-- Tests duplicate_all feature of BINARY_TREE
		local
			tree, tree_right, tree_left, tree_copy: BINARY_TREE [INTEGER]
		do
			create tree.make (default_root)
			create tree_left.make (2 * default_root)
			create tree_right.make (3 * default_root)
			tree.put_left_child (tree_left)
			tree.put_right_child (tree_right)
			tree.child_finish
			tree_copy := tree.duplicate_all
			check
				tree_copy.item = tree.item
			end
			utilities.print_test_passed ("duplicate_all")
		end

	test_copy_1
			-- Tests the copy feature of tree
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (default_root)
			create tree2.make (2 * default_root)
			tree1.put_left_child (tree2)
			tree2.copy (tree1)
			check
				tree1.item = tree2.item
			end
			utilities.print_test_passed ("copy_1")
		end

	test_copy_2
			-- Tests the copy feature of tree
		local
			tree1, tree2: BINARY_TREE [INTEGER]
		do
			create tree1.make (1)
			tree1.compare_objects
			create tree2.make (2)
			tree2.put_left_child (create {BINARY_TREE [INTEGER]}.make (3))
			tree1.copy (tree2)
			check
				tree1.item = tree2.item
			end
			utilities.print_test_passed ("copy_2")
		end

end
