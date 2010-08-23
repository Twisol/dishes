require 'dishes'

describe Dishes::ServiceRouter do
  before do
    @sr = Dishes::ServiceRouter.new
  end

  it 'should start with no defined routes' do
    @sr.routes.size.should be 0
  end

  it 'should map an action with an actor' do
    chef = Class.new(Dishes::Actor)
    @sr.route :foo => chef

    @sr.routes.should include 'foo'
    @sr.routes['foo'].should == chef
  end

  it 'should map multiple actions at once' do
    chef = Class.new(Dishes::Actor)
    @sr.route [:foo, :bar] => chef

    @sr.routes.should include *['foo', 'bar']
    @sr.routes['foo'].should == chef
    @sr.routes['bar'].should == chef
  end

  it 'should namespace actions from another router' do
    sr2 = Dishes::ServiceRouter.new do
      route :bar => Class.new(Dishes::Actor)
      route [:aaa, :bbb] => Class.new(Dishes::Actor)
    end
    @sr.namespace :foo, sr2
    
    @sr.routes.should include 'foo:bar'
    @sr.routes.should include *['foo:aaa', 'foo:bbb']
  end
end