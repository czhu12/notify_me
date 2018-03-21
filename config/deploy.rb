# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "notify_me"
set :repo_url, "git@github.com:czhu12/notify_me.git"

set :ssh_options, {
  forward_agent: true,
  auth_methods: ["publickey"],
  keys: ["#{Dir.pwd}/.sshaws/keypair.pem"]
}


namespace :deploy do
  desc 'remove all docker volumes. This is necessary docker volumes ' \
    'create files as root, therefore needs sudo'
  task :cleanup do
    on roles :all do
      execute "sudo rm -rf #{current_path}/public"
    end
  end
  before "deploy", "deploy:cleanup"

  desc 'build docker instances for web and worker'
  task :setup do
    on roles :all do
      upload! '.env', "#{current_path}/.env"
      execute "mkdir #{current_path}/log && mkdir #{current_path}/tmp"
    end
  end
  after "deploy", "deploy:setup"

  desc 'build and start docker instances for web and worker'
  task :stop do
    on roles :all do
      execute "docker network prune -f"
      execute "docker rm -f $(docker ps -aq) || true"
    end
  end
  after "deploy:setup", "deploy:stop"

  desc 'build and start docker instances for web and worker'
  task :start do
    on roles :all do
      execute "cd #{current_path} && docker-compose up --build"
    end
  end
  after "deploy:stop", "deploy:start"
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/notify_me"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
