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

  def preorder(node = root, visited = [], &block)
    block_given? ? yield(node) : visited << node.data
    preorder(node.left, visited, &block) unless node.left.nil?
    preorder(node.right, visited, &block) unless node.right.nil?
    block_given? ? nil : visited
  end

  def inorder(node = root, visited = [], &block)
    inorder(node.left, visited, &block) unless node.left.nil?
    block_given? ? yield(node) : visited << node.data
    inorder(node.right, visited, &block) unless node.right.nil?
    block_given? ? nil : visited
  end

  def postorder(node = root, visited = [], &block)
    postorder(node.left, visited, &block) unless node.left.nil?
    postorder(node.right, visited, &block) unless node.right.nil?
    block_given? ? yield(node) : visited << node.data
    block_given? ? nil : visited
  end
end
