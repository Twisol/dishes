require 'dishes'

describe Dishes::ServiceRouter do
  before do
    @sr = Dishes::ServiceRouter.new
  end

  it 'should start with no defined routes' do
    @sr.routes.length.should be 0
  end

  it 'should match an action with a chef' do
    @sr.route :foo => Class.new(Dishes::Chef)
    @sr.routes.should include 'foo'
  end

  it 'should match multiple actions with a chef' do
    @sr.route [:foo, :bar] => Class.new(Dishes::Chef)
    @sr.routes.should include *['foo', 'bar']
  end

  it 'should let actions be namespaced' do
    @sr.namespace :foo do
      route :bar => Class.new(Dishes::Chef)
      route [:aaa, :bbb] => Class.new(Dishes::Chef)
    end
    @sr.routes.should include 'foo:bar'
    @sr.routes.should include *['foo:aaa', 'foo:bbb']
  end
end