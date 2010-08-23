require 'dishes'

EchoService = Dishes::Service.new do
  namespace :math do
    route [:add, :sub, :div, :mul] => Class.new(Dishes::Actor)
  end
end

describe Dishes::Service do
  it 'should raise an error on an invalid query' do
    lambda {EchoService.query('bar')}.should raise_error
  end

  it 'should return a job ID to a valid query' do
    EchoService.query('math:add').should be_a_kind_of Integer
  end
end