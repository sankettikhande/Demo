
#load 'config/recipes/db'
# load "config/recipes/delayed_job"
# default_run_options[:shell] = '/bin/bash'
set :repository, "git@github.com:sodel/bluecompass.git"
set :application, 'bluecompass'
set :deploy_to, "/data/apps/#{application}"
set :deploy_via, :remote_cache
set :scm, 'git'
default_run_options[:pty] = true


set :scm_verbose, true
set :use_sudo, false
set :keep_releases, 2
set :precompile_only_if_changed, true
set :rails_env, "production"

task :qa do
  default_run_options[:pty] = true
  set :branch, 'qa'

  # be sure to change these
  set :user, ''
  set :domain, 'bluecompass.sodelsolutions.com'
  set :deploy_env, 'qa'

  # the rest should be good
  role :db, domain, :primary => true
  server domain, :app, :web
end


namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :copy_configs do
    run "cp #{release_path}/config/newrelic.yml.#{deploy_env} #{release_path}/config/newrelic.yml"
    run "cp #{release_path}/config/settings.yml.#{deploy_env} #{release_path}/config/settings.yml"
  end

  task :change_permission_for_fcgi do
    run "chmod +x #{current_path}/public/dispatch.fcgi"
  end

  task :change_permission_for_tmp do
    run "chmod -R 777 #{current_path}/tmp"
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => {:no_release => true} do
      logger.info "Skipping asset pre-compilation because there were no asset changes"
    end
  end
end

after "deploy:update_code", "db:symlink", "deploy:copy_configs", "deploy:migrate"
after "deploy:update", "deploy:cleanup"
after "deploy:create_symlink", "deploy:change_permission_for_tmp"