default_run_options[:pty] = true
set :application, "contrack"
set :repository,  "git@github.com:barbergeek/contrac.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "rails"
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache

role :web, "contrack.scotthoge.com"                          # Your HTTP server, Apache/etc
role :app, "contrack.scotthoge.com"                          # This may be the same as your `Web` server
role :db,  "contrack.scotthoge.com", :primary => true # This is where Rails migrations will run
role :db,  "contrack.scotthoge.com"

set :bundle_gemfile,  "Gemfile"
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    "--deployment --quiet"
set :bundle_without,  [:development, :test]
set :bundle_cmd,      "bundle" # e.g. "/opt/ruby/bin/bundle"
#set :bundle_roles,    {:except => {:no_release => true}} # e.g. [:app, :batch]

require "bundler/capistrano"
require "rvm/capistrano"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
      run "#{try_sudo} service thin restart"
      run "#{try_sudo} service nginx restart"
  end
end