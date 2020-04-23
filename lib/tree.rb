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
    max_edges = dig(node) - 1
    max_edges.negative? ? nil : max_edges
  end

  def bst?(node = root)
    should_be_sorted = inorder(node)
    should_be_sorted == should_be_sorted.uniq.sort
  end

  def balanced?(node = root)
    return true if depth(node) == 1 || node.nil?

    depth_left = depth(node.left) || 0
    depth_right = depth(node.right) || 0
    return false if (depth_left - depth_right).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance!
    @root = balance(nodes_in_order)
    self
  end

  def balance(nodes_ary)
    return nil if nodes_ary.empty?

    mid = nodes_ary.length / 2
    root = nodes_ary[mid]

    root.left = mid.zero? ? nil : balance(nodes_ary[0..mid - 1])
    root.right = balance(nodes_ary[mid + 1..-1])
    root
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

  def dig(node)
    return 0 if node.nil?

    [dig(node.left), dig(node.right)].max + 1
  end

  def rebuild(node, parent, kids, drift)
    node == root ? @root = kids.first : parent.send(drift + '=', kids.first)
    line_up(kids.last) if kids.size == 2
  end

  def nodes_in_order
    inorder_nodes = []
    inorder { |node| inorder_nodes << node }
    inorder_nodes.each { |node| orphan(node) }
  end

  def orphan(node)
    node.left = nil
    node.right = nil
  end
end
