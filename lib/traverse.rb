#!/usr/bin/env ruby
# frozen_string_literal: true

# provides traversal methods for binary trees
module Traversal
  def level_order
    node = root
    visited = []
    queue = [nil]
    until queue.empty?
      block_given? ? yield(node) : visited << node.data
      queue = (queue << node.left << node.right).reject(&:nil?)
      node = queue.shift
    end
    block_given? ? nil : visited
  end

  %w[pre in post].each do |prefix|
    define_method "#{prefix}order" do |node = root, visited = [], &block|
      visit(node, visited, &block) if prefix == 'pre'
      send "#{prefix}order", node.left, visited, &block if node.left
      visit(node, visited, &block) if prefix == 'in'
      send "#{prefix}order", node.right, visited, &block if node.right
      visit(node, visited, &block) if prefix == 'post'
      block.nil? ? visited : nil
    end
  end

  def visit(node, visited)
    block_given? ? yield(node) : visited << node.data
  end
end
