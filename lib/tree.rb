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
    kids = level_order(node)[1..-1].map { |n| find(n) }.each { |n| orphan(n) }

    rebuild(node, parent, kids, drift)
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
    case kids.length
    when 0
      node == root ? @root = nil : parent.send(drift + '=', nil)
    when 1
      node == root ? @root = kids.first : parent.send(drift + '=', kids.first)
    else
      parent.nil? ? @root = kids.shift : parent.send(drift + '=', nil)
      kids.each { |n| line_up(n, parent ||= root) }
    end
    self
  end

  def orphan(node)
    node.left = nil
    node.right = nil
  end
end
