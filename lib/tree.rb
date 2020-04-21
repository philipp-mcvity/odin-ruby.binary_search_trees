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

  def delete(value); end

  def find(value)
    node = root
    until node.nil?
      return node if node.data == value

      node = (value < node.data ? node.left : node.right)
    end
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
end
