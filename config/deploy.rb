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
after "deploy:update_code", "symlink_files"

task :symlink_files do
  [';-)'].each do |folder|
    path  = "#{release_path}/../../shared/files/#{folder}"
    symlink_path = "#{release_path}/public/#{folder}"
    run "mkdir -p \"#{path}\""
    puts "Symlinking #{folder} folder"
    run "rm -rf \"#{symlink_path}\""
    run "ln -sf \"#{path}\" \"#{symlink_path}\""
  end
end

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



# migrate on 23 apr 2011
#
#task :migrating, :roles => :app do
#  run "cd #{current_path} && rake migrate:shown_date_date_to_integer RAILS_ENV=production"
#end

# migrate 2 migrations. 26 mar, second migration return error, complete by hands
#task :migrating, roles: :app do
#  run "cd #{current_path} && rake migrate:organize_commented_images RAILS_ENV=production"
#  run "cd #{current_path} && rake migrate:ensure_nick RAILS_ENV=production"
#end