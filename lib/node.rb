#!/usr/bin/env ruby
# frozen_string_literal: true

# instantiates nodes for binary search trees
class Node
  include Comparable
  attr_accessor :left, :right
  attr_reader :data

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
end
