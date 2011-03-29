# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                   "Scott Hoge"
  user.email                  "scott.hoge@gmail.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.define :admin, :parent => :user do |u|
  u.roles                     ["admin"]
end

Factory.define :announcement do |ann|
  ann.author  "scott"
  ann.content "this is the text"
  ann.title   "this is the title"
end

Factory.define :opportunity do |opp|
  opp.program           'test'
  opp.department        'test'
end
  
#Factory.sequence :email do |n|
#  "person-#{n}@example.com"
#end
#
#Factory.define :micropost do |micropost|
#  micropost.content "Foo bar"
#  micropost.association :user
#end