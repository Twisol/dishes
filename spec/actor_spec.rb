require 'dishes'

def new_actor (&blk)
  Class.new(Dishes::Actor) do
    define_method :act, &blk
  end
end

describe Dishes::Actor do
  it 'should act and return a result' do
    actor_class = new_actor {42}
    actor = actor_class.new

    actor.should.respond_to? :act
    actor.act.should == 42
  end

  it 'should accept parameters' do
    actor_class = new_actor {@params['a'] + @params['b']}
    actor = actor_class.new('a' => 2, 'b' => 2)
    
    actor.act.should == 4
  end
end