# This is a GOAL EXAMPLE. It probably doesn't work, full stop. This code gives
# you an idea of the current target syntax and feature set.

require 'bundler'
Bundler.setup

require 'dishes'

class MathMenu < Dishes::Menu
  before :set_operands

  def add
    @left + @right
  end

  def subtract
    @left - @right
  end

  def multiply
    @left * @right
  end

  def divide
    error if @right == 0
    @left / @right
  end

  private
  def set_operands
    @left, @right = @data[:left], @data[:right]
  end
end

run Dishes::Restaurant.build {
  menu MathMenu
}