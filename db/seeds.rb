# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

unless admin=User.find_by_initials("SNH")
  admin = User.create!(
                :name => "Scott Hoge",
                :initials => "SNH",
                :email => "scott.hoge@gmail.com",
<<<<<<< HEAD
                :password => "foo123",
                :password_confirmation => "foo123")
end
admin.roles=%w[admin capture_manager] #make him an admin
admin.save!
=======
                :password => "foobar",
                :password_confirmation => "foobar")
end
admin.roles=%w[admin capture_manager] #make him an admin
admin.save!


              
>>>>>>> reports1
