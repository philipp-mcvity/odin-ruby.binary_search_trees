#!/usr/bin/env ruby
# frozen_string_literal: true

# instantiates nodes for binary search trees
class Node
  include Comparable
  attr_reader :left, :right, :data

  def <=>(other)
    data <=> other.data
  end

  def initialize(left = nil, right = nil, data = nil)
    @left = left
    @right = right
    @data = data
  end
end
