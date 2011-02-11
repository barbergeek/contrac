# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

 admin = User.create!(:email => "scott.hoge@gmail.com",
              :password => "foobar",
              :password_confirmation => "foobar")
 admin.roles=["admin"] #make him an admin
 admin.save!