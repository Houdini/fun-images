set :application, "fun-images"
set :repository,  "git@github.com:Houdini/fun-images.git"
set :user, 'houdini'


set :ssh_options, { :forward_agent => true }
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

set :scm, :git


set :use_sudo, false
set :deploy_to, "/home/#{user}/www/#{application}"


set :domain, "#{user}@188.127.228.220"
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db, domain

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end


before "deploy:symlink", "deploy:bundle_install"
#after "deploy:bundle_install", "deploy:update_crontab"

namespace :deploy do
  desc "run bundler install"
  task :bundle_install, :roles => :app do
    run "cd #{current_release} && bundle install --without test"
  end

  desc "clear cache"
  task :clear_cache, :roles => :app do
    run "cd #{current_release} && rake cache:clear_all RAILS_ENV=production"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "RUBYOPT='-Ku' && cd #{current_release} && whenever --update-crontab #{application}"
  end
end

#
#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end