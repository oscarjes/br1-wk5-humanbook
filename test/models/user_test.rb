require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add friend should add a stranger user as a friend " do 
    a = User.create(name: "Quy", email: "quy@a.com", password: "123")
    b = User.create(name: "Oscar", email: "oscar@a.com", password: "1234")
    a.add_friend(b)
    assert_includes a.friends, b 
    assert_equal 1, a.friends.count 
  end 

   test "is_friend? returns true after adding friend " do 
    a = User.create(name: "Quy", email: "quy@a.com", password: "123")
    b = User.create(name: "Oscar", email: "oscar@a.com", password: "1234")
    a.add_friend(b)
    assert a.is_friend?(b) 
  end 

  test "add friend should not add a stranger as a friend twice" do 
    a = User.create(name: "Quy", email: "quy@a.com", password: "123")
    b = User.create(name: "Oscar", email: "oscar@a.com", password: "1234")
    a.add_friend(b)
    a.add_friend(b)
    assert_equal 1, a.friends.count
  end 

  test "Removing friends works " do 
    a = User.create(name: "Quy", email: "quy@a.com", password: "123")
    b = User.create(name: "Oscar", email: "oscar@a.com", password: "1234")
    a.add_friend(b)
    assert_equal 1, a.friends.count
    a.remove_friend(b)
    assert_equal 0, a.friends.count
  end 


end
