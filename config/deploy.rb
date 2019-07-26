# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "sokudoku-bunko"
set :repo_url, "git@github.com:toywonder/sokudoku-bunko.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# リリースするブランチ名を記述↓
set :branch, 'release/0.0.2'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/sokudoku-bunko"

set :rbenv_ruby, '2.6.3'

set :yarn_flags, "--prefer-offline --production --no-progress"
set :yarn_roles, :app

# シンボリックリンクをはるファイル。(※後述)
set :linked_files, fetch(:linked_files, []).push('config/master.key')

# シンボリックリンクをはるフォルダ。(※後述)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数
set :keep_releases, 5

#出力するログのレベル。
set :log_level, :debug

# 参照するパス
set :bundle_binstubs, -> { shared_path.join('bin') }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end


  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
