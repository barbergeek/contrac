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
                :password => "foobar",
                :password_confirmation => "foobar")
end
admin.roles=%w[admin capture_manager] #make him an admin
admin.save!

unless user=User.find_by_initials("RD")
  user = User.create!(
                :name => "Richard Dinnis",
                :initials => "RD",
                :email => "rdinnis@inteprosfed.com",
                :password => "foo123",
                :password_confirmation => "foo123")
end
user.roles=%w[senior_manager]
user.save!

unless user=User.find_by_initials("MH")              
  user = User.create!(
                :name => "Margaret Hudson",
                :initials => "MH",
                :email => "mhudson@inteprosfed.com",
                :password => "foo123",
                :password_confirmation => "foo123")
end
user.roles=%w[business_developer bd_manager]
user.save!

unless user=User.find_by_initials("BG")
  user = User.create!(
                :name => "Brian Giblin",
                :initials => "BG",
                :email => "bgiblin@inteprosfed.com",
                :password => "foo123",
                :password_confirmation => "foo123")
end
user.roles=%w[business_developer]
user.save!

unless user=User.find_by_initials("EH")
  user = User.create!(
                :name => "Eileen Heller",
                :initials => "EH",
                :email => "eheller@inteprosfed.com",
                :password => "foo123",
                :password_confirmation => "foo123")
end
user.roles=%w[business_developer]
user.save!

              