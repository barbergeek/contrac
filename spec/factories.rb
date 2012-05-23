# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do
  factory :user do |user|
    user.name                   "Scott Hoge"
    user.email                  { FactoryGirl.generate(:email) }
    user.password               "foobar"
    user.password_confirmation  "foobar"
  end

  factory :admin, :parent => :user do |u|
    u.roles                     ["admin"]
  end

  factory :bd, :parent => :user do |u|
    u.roles                     ["business_developer"]
  end

  factory :capture_manager, :parent => :user do |u|
    u.roles                     ["capture_manager"]
  end

  factory :announcement do |ann|
    ann.author  "scott"
    ann.content "this is the text"
    ann.title   "this is the title"
  end

  factory :opportunity do |opp|
    opp.program           'program name'
    opp.department        'department name'
  end
  
  sequence :email do |n|
    "person-#{n}@example.com"
  end

end

#
#Factory.define :micropost do |micropost|
#  micropost.content "Foo bar"
#  micropost.association :user
#end