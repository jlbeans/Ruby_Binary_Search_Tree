# frozen_string_literal: true

require_relative 'Tree'

bst = Tree.new(Array.new(15) { rand(1..100) })

bst.pretty_print

p "Balanced?: #{bst.balanced?}"
p "Breadth-first level order: #{bst.level_order}"
p 'Depth-first order: '
p "1. In-order traversal: #{bst.inorder}"
p "2. Pre-order traversal: #{bst.preorder}"
p "3. Post-order traversal: #{bst.postorder}"

p 'Adding new data...'
bst.insert(121)
bst.insert(171)
bst.insert(127)
bst.insert(159)
bst.insert(111)
bst.insert(105)

bst.pretty_print
p "Balanced?: #{bst.balanced?}"
p 'Rebalancing...'
bst.rebalance
bst.pretty_print
p "Rebalanced?: #{bst.balanced?}"
p "Breadth-first level order: #{bst.level_order}"
p 'Depth-first order: '
p "1. In-order traversal: #{bst.inorder}"
p "2. Pre-order traversal: #{bst.preorder}"
p "3. Post-order traversal: #{bst.postorder}"
