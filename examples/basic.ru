# This is a GOAL EXAMPLE. It probably doesn't work fully. This code gives
# you an idea of the current target syntax and feature set.

lib = File.expand_path('../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dishes'

class ArithmeticChef < Dishes::Chef
  before :auth, :set_operands

  def add
    @left + @right
  end

  def sub
    @left - @right
  end

  def mul
    @left * @right
  end

  def div
    raise 'Attempt to divide by zero' if @right == 0
    @left / @right
  end
  
private
  def auth
    # Use Warden to ensure the user is a qualified mathematician.
  end

  def set_operands
    @left, @right = @params[:left], @params[:right]
  end
end

use Rack::CommonLogger
run Dishes::Service.new do
  namespace :math do
    route [:add, :sub, :div, :mul] => ArithmeticChef
  end
end