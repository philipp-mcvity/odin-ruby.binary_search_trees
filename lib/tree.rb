#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'node.rb'
require_relative 'traverse.rb'

# represents the full binary search tree-objects
class Tree
  include Traversal
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.uniq)
  end

  def insert(value)
    line_up(Node.new(value)) unless find(value)
    self
  end

  def find(value)
    node = root
    until node.nil?
      return node if node.data == value

      node = (value < node.data ? node.left : node.right)
    end
  end

  def delete(value)
    return unless (node = find(value))

    parent = parent(node)
    drift = (parent.left == node ? 'left' : 'right') unless parent.nil?
    kids = [node.left, node.right].reject(&:nil?)
    rebuild(node, parent, kids, drift)
    self
  end

  def depth(node = root)
    return 0 if node.nil?

    left = depth(node.left)
    right = depth(node.right)
    [left, right].max + 1
  end

  def bst?(node = root)
    should_be_sorted = inorder(node)
    should_be_sorted == should_be_sorted.uniq.sort
  end

  def balanced?(node = root)
    return true if depth(node) == 1 || node.nil?
    return false if (depth(node.left) - depth(node.right)).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  private

  def build_tree(array)
    root_node = Node.new(array.shift)
    array.each do |i|
      line_up(Node.new(i), root_node)
    end
    root_node
  end

  def line_up(node, root_node = root)
    other = root_node
    loop do
      move = (node < other ? other.left : other.right)
      break if move.nil?

      other = move
    end
    node < other ? other.left = node : other.right = node
  end

  def parent(node)
    return nil if node == root

    parent = root
    until parent.nil?
      return parent if [parent.left, parent.right].include?(node)

      parent = (node.data < parent.data ? parent.left : parent.right)
    end
  end

  def rebuild(node, parent, kids, drift)
    node == root ? @root = kids.first : parent.send(drift + '=', kids.first)
    line_up(kids.last) if kids.size == 2
  end
end
