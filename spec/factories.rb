# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                   "Scott Hoge"
  user.email                  { Factory.next(:email) }
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.define :admin, :parent => :user do |u|
  u.roles                     ["admin"]
end

Factory.define :bd, :parent => :user do |u|
  u.roles                     ["business_developer"]
end

Factory.define :capture_manager, :parent => :user do |u|
  u.roles                     ["capture_manager"]
end

Factory.define :announcement do |ann|
  ann.author  "scott"
  ann.content "this is the text"
  ann.title   "this is the title"
end

Factory.define :opportunity do |opp|
  opp.program           'program name'
  opp.department        'department name'
end
  
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
#
#Factory.define :micropost do |micropost|
#  micropost.content "Foo bar"
#  micropost.association :user
#end