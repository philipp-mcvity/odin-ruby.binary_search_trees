#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tree.rb'

indent = 14

tree = Tree.new(15.times.map { rand(1..100) })
puts tree.display
puts "#{'balanced:'.ljust(indent)} #{tree.balanced?}\n\n"
puts 'elements:'
puts "#{'level order:'.ljust(indent)} #{tree.level_order}"
puts "#{'preorder:'.ljust(indent)} #{tree.preorder}"
puts "#{'inorder:'.ljust(indent)} #{tree.inorder}"
puts "#{'postorder:'.ljust(indent)} #{tree.postorder}\n\n"
puts 'tbc'
