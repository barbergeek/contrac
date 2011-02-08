require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_opportunities
    #make_users
    #make_microposts
    #make_relationships
  end
end

def make_opportunities
  5.times do
    department = "Department of " + Faker::Company.bs.split(' ')[1..2].map{|f| f.capitalize}.join(' ')
    4.times do
      program = Faker::Company.catch_phrase.split(' ').map{|f| f.capitalize}.join(' ')
      acronym = program.split('-').join(' ').split(' ').map{|f| f[0]}.join('').upcase # take the first character of each word in the program
      opp = Opportunity.create!(
        :acronym => acronym,
        :program => program,
        :department => department,
        :agency => Faker::Company.bs.split(' ')[1..2].map{|f| f.capitalize}.join(' ') + " Agency",
        :description => Faker::Lorem.sentences.join(' ')
      )
    end
  end
end

# def make_users
#   admin = User.create!(:name => "Example User",
#                :email => "example@railstutorial.org",
#                :password => "foobar",
#                :password_confirmation => "foobar")
#   admin.toggle!(:admin) #make him an admin
#
#   99.times do |n|
#     name = Faker::Name.name
#     email = "example-#{n+1}@railstutorial.org"
#     password = "password"
#     User.create!(:name => name,
#                  :email => email,
#                  :password => password,
#                  :password_confirmation => password)
#   end
# end
#
# def make_microposts
#   User.all(:limit => 6).each do |user|
#     50.times do
#       user.microposts.create!(:content => Faker::Lorem.sentence(5))
#     end
#   end
# end
#
# def make_relationships
#   users = User.all
#   user = users.first
#   following = users [1..50]
#   followers = users[3..40]
#   following.each { |followed| user.follow!(followed) }
#   followers.each { |follower| follower.follow!(user) }
# end
