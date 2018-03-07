require 'spec_helper'

describe('User') do
  it("Searches by name") do
    user1 = User.create({:name => "Emily", :password => "ewiru", :id => nil})
    user2 = User.create({:name => "Ron", :password => "riotfdlkg", :id => nil})
    expect(User.findbyname("Emily")).to(eq(user1.id))
  end

  it("validates presence of User name") do
    user = User.new({:name => "", :password => "asdas"})
    expect(user.save()).to(eq(false))
  end

  it("validates presence of password") do
    user = User.new({:name => "a".*(16), :password => ""})
    expect(user.save()).to(eq(false))
  end

  it("validates length of user name is less than 20 characters") do
    user = User.new({:name => "a".*(21), :password => "sefafa"})
    expect(user.save()).to(eq(false))
  end

  it("tests for user name uniqueness") do
    user = User.create({:name => "Emily", :password => "sefafa"})
    user2 = User.new({:name => "Emily", :password => "faefasd"})
    expect(user2.save()).to(eq(false))
  end

  describe(".findtotrade") do
    it("find growers who want to trade for certain produce.") do
      user1 = User.create({:name => "Emily", :password => "sefafa", :id => 234})
      produce1 = Produce.create({:produce_type => "kale", :description => "a".*(10), :trade => "blueberries", :user_id => 234})
      produce2 = Produce.create({:produce_type => "grape", :description => "a".*(10), :trade => "strawberries", :user_id => 234})
      user2 = User.create({:name => "Jon", :password => "asdas", :id => 456})
      produce3 = Produce.create({:produce_type => "pumpkins", :description => "a".*(10), :trade => "lettuce", :user_id => 456})
      produce4 = Produce.create({:produce_type => "hops", :description => "a".*(10), :trade => "strawberries", :user_id => 456})
      user3 = User.create({:name => "Ralph", :password => "grae", :id => 123})
      produce5 = Produce.create({:produce_type => "corn", :description => "a".*(10), :trade => "tomatoes", :user_id => 123})
      expect(User.findtotrade("strawberries")).to(eq([user1, user2]))
    end
  end
end
