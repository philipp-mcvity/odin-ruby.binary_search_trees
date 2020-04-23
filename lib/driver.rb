#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tree.rb'

indent = 15

tree = Tree.new(15.times.map { rand(1..100) }).rebalance!
puts tree.display
puts "#{'balanced:'.ljust(indent)} #{tree.balanced?}\n\n"
puts 'elements'
puts "#{'level order:'.ljust(indent)} #{tree.level_order}"
puts "#{'preorder:'.ljust(indent)} #{tree.preorder}"
puts "#{'inorder:'.ljust(indent)} #{tree.inorder}"
puts "#{'postorder:'.ljust(indent)} #{tree.postorder}\n\n"
inserts = 5.times.map { rand(111..333) }
puts "#{'insert:'.ljust(indent)} #{inserts[0..3].join(', ')} and #{inserts[-1]}"
inserts.each { |n| tree.insert(n) }
puts "#{'balanced:'.ljust(indent)} #{tree.balanced?}\n\n"
puts "#{'rebalancing:'.ljust(indent)} #{tree.rebalance!}"
puts "#{'balanced:'.ljust(indent)} #{tree.balanced?}\n\n"
puts 'elements'
puts "#{'level order:'.ljust(indent)} #{tree.level_order}"
puts "#{'preorder:'.ljust(indent)} #{tree.preorder}"
puts "#{'inorder:'.ljust(indent)} #{tree.inorder}"
puts "#{'postorder:'.ljust(indent)} #{tree.postorder}"
